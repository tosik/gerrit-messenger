class Gerrit::Messenger::Models::PatchsetCreated
  include Gerrit::Messenger::Models::CommonEvent

  def initialize(json)
    @json = json
  end
end
