require 'spec_helper'
require_relative '../../../../apps/web/controllers/entries/create'

describe Web::Controllers::Entries::Create do
  let(:action) { Web::Controllers::Entries::Create.new }

  it 'creates an entry for a player' do
    params = {
      'name' => 'colin',
      'email' => 'asdf@asdf.com',
      'mascots' => [
        {'name' => 'oregon ducks'},
        {'name' => 'oklahoma sooners'},
        {'name' => 'western kentucky hilltoppers'},
      ],
    }
    response = action.call(params)

    entry = EntryRepository.latest_by_name(params.fetch('name'))
    entry.email.must_equal params.fetch('email')
    entry.data.fetch('mascots').must_equal params.fetch('mascots')

    response[0].must_equal 200
  end
end
