require 'net/ssh'

class Gerrit::Messenger::Connector

  def initialize(host, user, port)
    @host = host
    @user = user
    @port = port
  end

  def stream
    Net::SSH.start(@host, @user, port: @port) do |ssh|
      ssh.exec('gerrit stream-events') do |channel, stream, data|
        yield data
      end
    end
  end

end