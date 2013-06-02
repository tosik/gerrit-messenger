class Gerrit::Messenger::Models::CommentAdded
  include Gerrit::Messenger::Models::CommonEvent

  def initialize(json)
    @json = json
  end

  def score
    approvals = @json["approvals"].reduce({}) {|hash, approval|
      hash.merge(case approval['type']
      when 'VRIF'
        { verified: approval['value']}
      when 'CRVW'
        { codereview: approval['value']}
      end)
    }
    if approvals[:verified] == '1' and approvals[:codereview] == '2'
      'LGTM'
    else
      'DO NOT SUBMIT'
    end
  end

end
