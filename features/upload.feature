Feature: Uploads
  In order to contribute data to pcapr
  As a regular user
  I want to be able to upload a pcap file

  Scenario Outline: Upload a pcap file
    Given I have a pcap file <filename>
    When I upload the pcap file
    Then the pcap file should be uploaded

  Examples:
    | filename  |
    | test.pcap |

# vim: set ts=2 sw=2
