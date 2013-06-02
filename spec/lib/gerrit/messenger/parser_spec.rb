require 'spec_helper'

describe Gerrit::Messenger::Parser do
  let(:parser) { Gerrit::Messenger::Parser }
  subject { parser.parse(json) }

  context 'when comment-added parsed' do
    let(:json) do
      str = <<EOS
        {
          "type": "comment-added",
          "change": {
            "project": "project",
            "branch": "branch",
            "topic": "topic",
            "id": "id",
            "number": "12345",
            "subject": "It is the subject",
            "owner": {
              "name": "owner name",
              "email": "email",
              "username": "username"
            },
            "url": "http://it-is-url"
          },
          "patchSet": {
            "number": "1",
            "revision": "5e580e6bbfa20db98fe850106b7cab1e1d2b2c5a",
            "parents": ["657b4d1480d03a2b3900696f0240e151f0bff760"],
            "ref": "refs/changes/48/77248/1",
            "uploader": {
              "name": "name",
              "email": "email",
              "username": "usernmae"
            },
            "createdOn": 1366702415
          },
          "author": {
            "name": "author name",
            "email": "email",
            "username": "usernmae"
          },
          "approvals": [
            {
              "type": "VRIF",
              "description": "Verified",
              "value": "1"
            },
            {
              "type": "CRVW",
              "description": "Code Review",
              "value": "2"
            }
          ],
          "comment": "comment"
        }
EOS
      str
    end

    it { should == '[COMMENT][LGTM] owner name -> author name "It is the subject" http://it-is-url' }
  end
end