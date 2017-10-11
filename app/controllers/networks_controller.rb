class NetworksController < ApplicationController
  def index
    Nmap::Program.sudo_scan do |nmap|
      nmap.ports = [80]
      nmap.targets = '192.168.1.*'
      nmap.xml = 'tmp/scan.xml'
      nmap.syn_scan = true
      nmap.service_scan = true
      nmap.os_fingerprint = true
    end
    Scan.create(body: File.read(Rails.root.join('tmp', 'scan.xml')))
    Nmap::XML.new('tmp/scan.xml') do |xml|
      set_nmap_result xml
    end
  end

  private

  def set_nmap_result(result)
    @nmap_result = result
  end
end