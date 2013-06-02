require 'spec_helper'
require 'json'
require 'gerrit/messenger/models/comment_added'

describe Gerrit::Messenger::Models::CommentAdded do
  context 'correct json given' do
    subject { Gerrit::Messenger::Models::CommentAdded.new(JSON.parse(json)) }
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

    its(:score) { should == 'LGTM' }
    its(:author_name) { should == 'author name' }
    its(:owner_name) { should == 'owner name' }
    its(:subject) { should == 'It is the subject' }
    its(:url) { should == 'http://it-is-url' }
  end

  context 'score' do
    subject { Gerrit::Messenger::Models::CommentAdded.new(data).score }
    let(:data) { { "approvals" => [ { "type" => "VRIF", "value" => vrif_value.to_s }, { "type" => "CRVW", "value" => crvw_value.to_s } ] } }
    context 'when scores are 1, 2' do
      let(:vrif_value) { 1 }
      let(:crvw_value) { 2 }
      it { should == "LGTM" }
    end
    context 'when scores are 1, 1' do
      let(:vrif_value) { 1 }
      let(:crvw_value) { 1 }
      it { should == "DO NOT SUBMIT" }
    end
    context 'when scores are 0, 1' do
      let(:vrif_value) { 0 }
      let(:crvw_value) { 1 }
      it { should == "DO NOT SUBMIT" }
    end
    context 'when scores are -1, -2' do
      let(:vrif_value) { -1 }
      let(:crvw_value) { -2 }
      it { should == "DO NOT SUBMIT" }
    end
  end
end