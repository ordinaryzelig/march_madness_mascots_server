module Web::Controllers::Entries
  class Create
    include Web::Action

    def call(params)
      entry = Entry.new(
        name: params[:name],
        email: params[:email],
        data: {
          'mascots' => params[:mascots],
        },
      )
      EntryRepository.create(entry)
    end
  end
end
