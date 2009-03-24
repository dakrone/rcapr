Feature: Downloads
  In order to retrieve data from pcapr
  As a regular user
  I want to be able to download a pcap file

  Scenario Outline: Download a pcap file
    Given I have a pcap file id <p_id>
    When I download the pcap file
    Then the pcap file should be download

  Examples:
    | p_id |
    | f424b4421b0f3e0ab191dc90d8964fac |
    | c6be820e5c1cf9f9f37871602c7a8ed1 |

# vim: set ts=2 sw=2
