class ItemCategory < ActiveRecord::Base
  include PgSearch

  belongs_to :company
  has_many :items

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :deposit, numericality: { greater_than: 0 }, allow_blank: true
  validates :company, presence: true

  pg_search_scope :search_by_name,
                  against: :name,
                  using: {
                    tsearch: { prefix: true }
                  }

  def as_json(options)
    { id: id, text: name }
  end
end
