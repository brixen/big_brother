module BigBrother
  class Cluster

    def initialize(name, attributes = {})
      @name = name
      @check_interval = attributes.fetch(:check_interval, 1)
      @monitored = false
      @nodes = attributes.fetch(:nodes, [])
      @last_check = Time.new(0)
    end

    def monitored?
      @monitored
    end

    def start_monitoring!
      @monitored = true
    end

    def stop_monitoring!
      @monitored = false
    end

    def needs_check?
      @last_check + @check_interval < Time.now
    end

    def monitor_nodes
      @nodes.each(&:current_health)
      @last_check = Time.now
    end
  end
end
