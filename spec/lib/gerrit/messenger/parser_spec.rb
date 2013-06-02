require 'spec_helper'

describe Gerrit::Messenger::Parser do
  let(:parser) { Gerrit::Messenger::Parser }

  describe '#create_comment_added_message' do
    subject { parser.create_comment_added_message('dummy') }

    before do
      Gerrit::Messenger::Models::CommentAdded.any_instance.stub(
        score: 'LGTM',
        owner_name: 'owner name',
        author_name: 'author name',
        subject: 'It is the subject',
        url: 'http://it-is-url',
      )
    end

    it { should == '[COMMENT][LGTM] owner name -> author name "It is the subject" http://it-is-url' }
  end

  describe '#create_patchset_created_message' do
    subject { parser.create_patchset_created_message('dummy') }

    before do
      Gerrit::Messenger::Models::PatchsetCreated.any_instance.stub(
        owner_name: 'owner name',
        author_name: 'author name',
        subject: 'It is the subject',
        url: 'http://it-is-url',
      )
    end

    it { should == '[NEW PATCHSET] owner name "It is the subject" http://it-is-url' }
  end
end