class Entry

  include Hanami::Entity

  attributes :name, :email, :data
  attributes :created_at, :updated_at

  def mail_to(to)
    sg = SendGrid::API.new(api_key: ENV.fetch('SENDGRID_API_KEY'))
    sg.client.mail._("send").post(request_body: mail_request_body(to))
  end

private

  MY_EMAIL = 'march-madness-mascots@redningja.com'.freeze

  def mail_content
    data.fetch('mascots')
      .each_with_index
      .map { |mascot, idx| "#{idx + 1} #{mascot.fetch('name')}" }
      .join("\n")
  end

  def mail_request_body(to)
    {
      'personalizations' => [
        {
          'to' => [
            {'email' => to},
            {'email' => MY_EMAIL},
          ],
          'subject' => "March Madness Mascots Entry: #{name} (id #{self.id})",
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
