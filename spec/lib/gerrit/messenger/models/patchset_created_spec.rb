require 'spec_helper'
require 'json'
require 'gerrit/messenger/models/patchset_created'

describe Gerrit::Messenger::Models::PatchsetCreated do
  context 'correct json given' do
    subject { Gerrit::Messenger::Models::PatchsetCreated.new(JSON.parse(json)) }
    let(:json) do
      str = <<EOS
        {
          "type":"patchset-created",
          "change":{
            "project":"project",
            "branch":"master",
            "id":"1232123123",
            "number":"1",
            "subject":"It is the subject",
            "owner":{
              "name":"owner name",
              "email":"owner email",
              "username":"owner username"
            },
            "url":"http://it-is-url/1"
          },
          "patchSet":{
            "number":"1",
            "revision":"1232123123",
            "parents":["00123123123"],
            "ref":"refs/changes/01/1/1",
            "uploader":{
              "name":"uploader name",
              "email":"uploader email",
              "username":"uploader username"
            },
            "createdOn":1370157880
          },
          "uploader":{
            "name":"uploader name",
            "email":"uploader email",
            "username":"uploader username"
          }
        }
EOS
      str
    end

    it { expect { subject.author_name }.to raise_error }
    its(:owner_name) { should == 'owner name' }
    its(:subject) { should == 'It is the subject' }
    its(:url) { should == 'http://it-is-url/1' }
  end
end

