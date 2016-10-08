module Web::Controllers::Entries
  class Create
    include Web::Action

    def call(params)
      entry = Entry.new(params)
      EntryRepository.create(entry)
    end
  end
end
