class Entry

  include Hanami::Entity

  attributes :name, :email, :data
  attributes :created_at, :updated_at

  def send_mail
    sg = SendGrid::API.new(api_key: ENV.fetch('SENDGRID_API_KEY'))
    request_body = mail_request_body([email, MY_EMAIL].compact)
    sg.client.mail._("send").post(request_body: request_body)
  end

private

  MY_EMAIL = 'jared@redningja.com'.freeze

  def mail_content
    data.fetch('mascots')
      .each_with_index
      .map { |mascot, idx| "#{idx + 1} #{mascot.fetch('school')} #{mascot.fetch('name')}" }
      .join("\n")
  end

  def mail_request_body(tos)
    {
      'personalizations' => [
        {
          'to' => tos.map { |to| {'email' => to} },
          'subject' => "March Madness Mascots Entry: #{name} (id #{id})",
        },
      ],
      'from' => {'email' => MY_EMAIL},
      'content' => [
        {
          'type' => 'text/plain',
          'value' => mail_content,
        },
      ],
    }
  end
end
