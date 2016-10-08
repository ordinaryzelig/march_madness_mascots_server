class EntryRepository

  include Hanami::Repository

  def self.latest_by_name(name)
    last do
      where(name: name)
        .order(:created_at)
    end
  end

end
