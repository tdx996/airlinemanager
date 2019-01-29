class Flight < ApplicationRecord

	self.per_page = 10


	before_save :default_values
	def default_values
		self.status ||= Flight.statuses[:ready_to_book]
	end

	# Relationships

	belongs_to :src_airport, class_name: 'Airport', foreign_key: 'src_airport_id'
	belongs_to :dst_airport, class_name: 'Airport', foreign_key: 'dst_airport_id'
	has_many :tickets
	has_many :passengers, through: :tickets

	# Validate

	validate :validate_airports
	validates :src_airport_id, presence: true
	validates :dst_airport_id, presence: true
	validates :price, presence: true, numericality: { greater_than: 0, less_than: 10000 }
	validates :capacity, presence: true, numericality: { greater_than: 10, less_than: 350 }
	validates_datetime :departure_at, :before => :arrival_at 
	validates_datetime :arrival_at, :after => :departure_at


	private def validate_airports
		errors.add(:src_airport_id, "Invalid") unless Airport.exists?(self.src_airport_id)
		errors.add(:dst_airport_id, "Invalid") unless Airport.exists?(self.dst_airport_id)
		errors.add(:src_airport_id, "and destination ariport can't be the same") unless self.src_airport_id != self.dst_airport_id
	end

	# Status

	enum status: {
		ready_to_book: 'ready_to_book',
		boarding: 'boarding',
		taking_off: 'taking_off',
		in_air: 'in_air',
		landing: 'landing',
		waiting: 'waiting',
	}

	def statusBadge
		@label = '<span class="badge badge-' + self.statusColor + '">' + Flight.human_enum_name(:status, self.status) + '</span>'
	end

	def statusColor
		case self.status
		when Flight.statuses[:ready_to_book]
			@color = "primary"
		when Flight.statuses[:boarding]
			@color = "warning"
		when Flight.statuses[:taking_off]
			@color = "warning"
		when Flight.statuses[:in_air]
			@color = "success"
		when Flight.statuses[:landing]
			@color = "warning"
		when Flight.statuses[:waiting]
			@color = "default"
		end
	end

	#

	def availableSeats
		@seats = {}
		@tickets = self.tickets.pluck(:seat)
		for i in 0..(self.capacity/6-1)
			for j in 0..5
				@seat = (i+1).to_s + "ABCDEF"[j].to_s
				unless @tickets.include?(@seat) 
					@seats[@seat] = @seat
				end
			end
		end
		return @seats
	end

	def self.pagination(params, user) 
		paginate(:page => params[:page]).where(airline_id: user.airline_id).order('departure_at DESC')
	end

end
