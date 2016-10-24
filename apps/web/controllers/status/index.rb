module Web::Controllers::Status
  class Index
    include Web::Action

    def call(params)
      self.body = 'OK'
    end
  end
end
