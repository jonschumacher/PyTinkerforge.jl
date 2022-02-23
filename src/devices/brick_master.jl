


export BrickMasterChibiErrorLog
struct BrickMasterChibiErrorLog
    underrun::Integer
    crc_error::Integer
    no_ack::Integer
    overflow::Integer
end

export BrickMasterRS485Configuration
struct BrickMasterRS485Configuration
    speed::Integer
    parity::Char
    stopbits::Integer
end

export BrickMasterWifiConfiguration
struct BrickMasterWifiConfiguration
    ssid::String
    connection::Integer
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    port::Integer
end

export BrickMasterWifiEncryption
struct BrickMasterWifiEncryption
    encryption::Integer
    key::String
    key_index::Integer
    eap_options::Integer
    ca_certificate_length::Integer
    client_certificate_length::Integer
    private_key_length::Integer
end

export BrickMasterWifiStatus
struct BrickMasterWifiStatus
    mac_address::Vector{Integer}
    bssid::Vector{Integer}
    channel::Integer
    rssi::Integer
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    rx_count::Integer
    tx_count::Integer
    state::Integer
end

export BrickMasterWifiCertificate
struct BrickMasterWifiCertificate
    data::Vector{Integer}
    data_length::Integer
end

export BrickMasterWifiBufferInfo
struct BrickMasterWifiBufferInfo
    overflow::Integer
    low_watermark::Integer
    used::Integer
end

export BrickMasterStackCurrentCallbackThreshold
struct BrickMasterStackCurrentCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickMasterStackVoltageCallbackThreshold
struct BrickMasterStackVoltageCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickMasterUSBVoltageCallbackThreshold
struct BrickMasterUSBVoltageCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickMasterEthernetConfiguration
struct BrickMasterEthernetConfiguration
    connection::Integer
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    port::Integer
end

export BrickMasterEthernetStatus
struct BrickMasterEthernetStatus
    mac_address::Vector{Integer}
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    rx_count::Integer
    tx_count::Integer
    hostname::String
end

export BrickMasterEthernetWebsocketConfiguration
struct BrickMasterEthernetWebsocketConfiguration
    sockets::Integer
    port::Integer
end

export BrickMasterReadWifi2SerialPort
struct BrickMasterReadWifi2SerialPort
    data::Vector{Integer}
    result::Integer
end

export BrickMasterWifi2Configuration
struct BrickMasterWifi2Configuration
    port::Integer
    websocket_port::Integer
    website_port::Integer
    phy_mode::Integer
    sleep_mode::Integer
    website::Integer
end

export BrickMasterWifi2Status
struct BrickMasterWifi2Status
    client_enabled::Bool
    client_status::Integer
    client_ip::Vector{Integer}
    client_subnet_mask::Vector{Integer}
    client_gateway::Vector{Integer}
    client_mac_address::Vector{Integer}
    client_rx_count::Integer
    client_tx_count::Integer
    client_rssi::Integer
    ap_enabled::Bool
    ap_ip::Vector{Integer}
    ap_subnet_mask::Vector{Integer}
    ap_gateway::Vector{Integer}
    ap_mac_address::Vector{Integer}
    ap_rx_count::Integer
    ap_tx_count::Integer
    ap_connected_count::Integer
end

export BrickMasterWifi2ClientConfiguration
struct BrickMasterWifi2ClientConfiguration
    enable::Bool
    ssid::String
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    mac_address::Vector{Integer}
    bssid::Vector{Integer}
end

export BrickMasterWifi2APConfiguration
struct BrickMasterWifi2APConfiguration
    enable::Bool
    ssid::String
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    encryption::Integer
    hidden::Bool
    channel::Integer
    mac_address::Vector{Integer}
end

export BrickMasterWifi2MeshConfiguration
struct BrickMasterWifi2MeshConfiguration
    enable::Bool
    root_ip::Vector{Integer}
    root_subnet_mask::Vector{Integer}
    root_gateway::Vector{Integer}
    router_bssid::Vector{Integer}
    group_id::Vector{Integer}
    group_ssid_prefix::String
    gateway_ip::Vector{Integer}
    gateway_port::Integer
end

export BrickMasterWifi2MeshCommonStatus
struct BrickMasterWifi2MeshCommonStatus
    status::Integer
    root_node::Bool
    root_candidate::Bool
    connected_nodes::Integer
    rx_count::Integer
    tx_count::Integer
end

export BrickMasterWifi2MeshClientStatus
struct BrickMasterWifi2MeshClientStatus
    hostname::String
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    mac_address::Vector{Integer}
end

export BrickMasterWifi2MeshAPStatus
struct BrickMasterWifi2MeshAPStatus
    ssid::String
    ip::Vector{Integer}
    subnet_mask::Vector{Integer}
    gateway::Vector{Integer}
    mac_address::Vector{Integer}
end

export BrickMasterSetBrickletXMCFlashConfig
struct BrickMasterSetBrickletXMCFlashConfig
    return_value::Integer
    return_data::Vector{Integer}
end

export BrickMasterSPITFPBaudrateConfig
struct BrickMasterSPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickMasterSPITFPErrorCount
struct BrickMasterSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickMasterProtocol1BrickletName
struct BrickMasterProtocol1BrickletName
    protocol_version::Integer
    firmware_version::Vector{Integer}
    name::String
end

export BrickMasterIdentity
struct BrickMasterIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickMaster
"""
Basis to build stacks and has 4 Bricklet ports
"""
mutable struct BrickMaster <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickMaster(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_master")
        deviceInternal = package.BrickMaster(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_stack_voltage
"""
    $(SIGNATURES)

Returns the stack voltage. The stack voltage is the
voltage that is supplied via the stack, i.e. it is given by a
Step-Down or Step-Up Power Supply.

.. note::
 It is not possible to measure voltages supplied per PoE or USB with this function.
"""
function get_stack_voltage(device::BrickMaster)
    return device.deviceInternal.get_stack_voltage()
end

export get_stack_current
"""
    $(SIGNATURES)

Returns the stack current. The stack current is the
current that is drawn via the stack, i.e. it is given by a
Step-Down or Step-Up Power Supply.

.. note::
 It is not possible to measure the current drawn via PoE or USB with this function.
"""
function get_stack_current(device::BrickMaster)
    return device.deviceInternal.get_stack_current()
end

export set_extension_type
"""
    $(SIGNATURES)

Writes the extension type to the EEPROM of a specified extension.
The extension is either 0 or 1 (0 is the lower one, 1 is the upper one,
if only one extension is present use 0).

Possible extension types:

.. csv-table::
 :header: "Type", "Description"
 :widths: 10, 100

 "1",    "Chibi"
 "2",    "RS485"
 "3",    "WIFI"
 "4",    "Ethernet"
 "5",    "WIFI 2.0"

The extension type is already set when bought and it can be set with the
Brick Viewer, it is unlikely that you need this function.
"""
function set_extension_type(device::BrickMaster, extension, exttype)
    device.deviceInternal.set_extension_type(extension, exttype)
end

export get_extension_type
"""
    $(SIGNATURES)

Returns the type for a given extension as set by :func:`Set Extension Type`.
"""
function get_extension_type(device::BrickMaster, extension)
    return device.deviceInternal.get_extension_type(extension)
end

export is_chibi_present
"""
    $(SIGNATURES)

Returns *true* if the Master Brick is at position 0 in the stack and a Chibi
Extension is available.
"""
function is_chibi_present(device::BrickMaster)
    return device.deviceInternal.is_chibi_present()
end

export set_chibi_address
"""
    $(SIGNATURES)

Sets the address belonging to the Chibi Extension.

It is possible to set the address with the Brick Viewer and it will be
saved in the EEPROM of the Chibi Extension, it does not
have to be set on every startup.
"""
function set_chibi_address(device::BrickMaster, address)
    device.deviceInternal.set_chibi_address(address)
end

export get_chibi_address
"""
    $(SIGNATURES)

Returns the address as set by :func:`Set Chibi Address`.
"""
function get_chibi_address(device::BrickMaster)
    return device.deviceInternal.get_chibi_address()
end

export set_chibi_master_address
"""
    $(SIGNATURES)

Sets the address of the Chibi Master. This address is used if the
Chibi Extension is used as slave (i.e. it does not have a USB connection).

It is possible to set the address with the Brick Viewer and it will be
saved in the EEPROM of the Chibi Extension, it does not
have to be set on every startup.
"""
function set_chibi_master_address(device::BrickMaster, address)
    device.deviceInternal.set_chibi_master_address(address)
end

export get_chibi_master_address
"""
    $(SIGNATURES)

Returns the address as set by :func:`Set Chibi Master Address`.
"""
function get_chibi_master_address(device::BrickMaster)
    return device.deviceInternal.get_chibi_master_address()
end

export set_chibi_slave_address
"""
    $(SIGNATURES)

Sets up to 254 slave addresses. 0 has a
special meaning, it is used as list terminator and not allowed as normal slave
address. The address numeration (via ``num`` parameter) has to be used
ascending from 0. For example: If you use the Chibi Extension in Master mode
(i.e. the stack has an USB connection) and you want to talk to three other
Chibi stacks with the slave addresses 17, 23, and 42, you should call with
``(0, 17)``, ``(1, 23)``, ``(2, 42)`` and ``(3, 0)``. The last call with
``(3, 0)`` is a list terminator and indicates that the Chibi slave address
list contains 3 addresses in this case.

It is possible to set the addresses with the Brick Viewer, that will take care
of correct address numeration and list termination.

The slave addresses will be saved in the EEPROM of the Chibi Extension, they
don't have to be set on every startup.
"""
function set_chibi_slave_address(device::BrickMaster, num, address)
    device.deviceInternal.set_chibi_slave_address(num, address)
end

export get_chibi_slave_address
"""
    $(SIGNATURES)

Returns the slave address for a given ``num`` as set by
:func:`Set Chibi Slave Address`.
"""
function get_chibi_slave_address(device::BrickMaster, num)
    return device.deviceInternal.get_chibi_slave_address(num)
end

export get_chibi_signal_strength
"""
    $(SIGNATURES)

Returns the signal strength in dBm. The signal strength updates every time a
packet is received.
"""
function get_chibi_signal_strength(device::BrickMaster)
    return device.deviceInternal.get_chibi_signal_strength()
end

export get_chibi_error_log
"""
    $(SIGNATURES)

Returns underrun, CRC error, no ACK and overflow error counts of the Chibi
communication. If these errors start rising, it is likely that either the
distance between two Chibi stacks is becoming too big or there are
interferences.
"""
function get_chibi_error_log(device::BrickMaster)
    return device.deviceInternal.get_chibi_error_log()
end

export set_chibi_frequency
"""
    $(SIGNATURES)

Sets the Chibi frequency range for the Chibi Extension. Possible values are:

.. csv-table::
 :header: "Type", "Description"
 :widths: 10, 100

 "0",    "OQPSK 868MHz (Europe)"
 "1",    "OQPSK 915MHz (US)"
 "2",    "OQPSK 780MHz (China)"
 "3",    "BPSK40 915MHz"

It is possible to set the frequency with the Brick Viewer and it will be
saved in the EEPROM of the Chibi Extension, it does not
have to be set on every startup.
"""
function set_chibi_frequency(device::BrickMaster, frequency)
    device.deviceInternal.set_chibi_frequency(frequency)
end

export get_chibi_frequency
"""
    $(SIGNATURES)

Returns the frequency value as set by :func:`Set Chibi Frequency`.
"""
function get_chibi_frequency(device::BrickMaster)
    return device.deviceInternal.get_chibi_frequency()
end

export set_chibi_channel
"""
    $(SIGNATURES)

Sets the channel used by the Chibi Extension. Possible channels are
different for different frequencies:

.. csv-table::
 :header: "Frequency", "Possible Channels"
 :widths: 40, 60

 "OQPSK 868MHz (Europe)", "0"
 "OQPSK 915MHz (US)",     "1, 2, 3, 4, 5, 6, 7, 8, 9, 10"
 "OQPSK 780MHz (China)",  "0, 1, 2, 3"
 "BPSK40 915MHz",         "1, 2, 3, 4, 5, 6, 7, 8, 9, 10"

It is possible to set the channel with the Brick Viewer and it will be
saved in the EEPROM of the Chibi Extension, it does not
have to be set on every startup.
"""
function set_chibi_channel(device::BrickMaster, channel)
    device.deviceInternal.set_chibi_channel(channel)
end

export get_chibi_channel
"""
    $(SIGNATURES)

Returns the channel as set by :func:`Set Chibi Channel`.
"""
function get_chibi_channel(device::BrickMaster)
    return device.deviceInternal.get_chibi_channel()
end

export is_rs485_present
"""
    $(SIGNATURES)

Returns *true* if the Master Brick is at position 0 in the stack and a RS485
Extension is available.
"""
function is_rs485_present(device::BrickMaster)
    return device.deviceInternal.is_rs485_present()
end

export set_rs485_address
"""
    $(SIGNATURES)

Sets the address (0-255) belonging to the RS485 Extension.

Set to 0 if the RS485 Extension should be the RS485 Master (i.e.
connected to a PC via USB).

It is possible to set the address with the Brick Viewer and it will be
saved in the EEPROM of the RS485 Extension, it does not
have to be set on every startup.
"""
function set_rs485_address(device::BrickMaster, address)
    device.deviceInternal.set_rs485_address(address)
end

export get_rs485_address
"""
    $(SIGNATURES)

Returns the address as set by :func:`Set RS485 Address`.
"""
function get_rs485_address(device::BrickMaster)
    return device.deviceInternal.get_rs485_address()
end

export set_rs485_slave_address
"""
    $(SIGNATURES)

Sets up to 255 slave addresses. Valid addresses are in range 1-255. 0 has a
special meaning, it is used as list terminator and not allowed as normal slave
address. The address numeration (via ``num`` parameter) has to be used
ascending from 0. For example: If you use the RS485 Extension in Master mode
(i.e. the stack has an USB connection) and you want to talk to three other
RS485 stacks with the addresses 17, 23, and 42, you should call with
``(0, 17)``, ``(1, 23)``, ``(2, 42)`` and ``(3, 0)``. The last call with
``(3, 0)`` is a list terminator and indicates that the RS485 slave address list
contains 3 addresses in this case.

It is possible to set the addresses with the Brick Viewer, that will take care
of correct address numeration and list termination.

The slave addresses will be saved in the EEPROM of the Chibi Extension, they
don't have to be set on every startup.
"""
function set_rs485_slave_address(device::BrickMaster, num, address)
    device.deviceInternal.set_rs485_slave_address(num, address)
end

export get_rs485_slave_address
"""
    $(SIGNATURES)

Returns the slave address for a given ``num`` as set by
:func:`Set RS485 Slave Address`.
"""
function get_rs485_slave_address(device::BrickMaster, num)
    return device.deviceInternal.get_rs485_slave_address(num)
end

export get_rs485_error_log
"""
    $(SIGNATURES)

Returns CRC error counts of the RS485 communication.
If this counter starts rising, it is likely that the distance
between the RS485 nodes is too big or there is some kind of
interference.
"""
function get_rs485_error_log(device::BrickMaster)
    return device.deviceInternal.get_rs485_error_log()
end

export set_rs485_configuration
"""
    $(SIGNATURES)

Sets the configuration of the RS485 Extension. The
Master Brick will try to match the given baud rate as exactly as possible.
The maximum recommended baud rate is 2000000 (2MBd).
Possible values for parity are 'n' (none), 'e' (even) and 'o' (odd).

If your RS485 is unstable (lost messages etc.), the first thing you should
try is to decrease the speed. On very large bus (e.g. 1km), you probably
should use a value in the range of 100000 (100kBd).

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.
"""
function set_rs485_configuration(device::BrickMaster, speed, parity, stopbits)
    device.deviceInternal.set_rs485_configuration(speed, parity, stopbits)
end

export get_rs485_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set RS485 Configuration`.
"""
function get_rs485_configuration(device::BrickMaster)
    return device.deviceInternal.get_rs485_configuration()
end

export is_wifi_present
"""
    $(SIGNATURES)

Returns *true* if the Master Brick is at position 0 in the stack and a WIFI
Extension is available.
"""
function is_wifi_present(device::BrickMaster)
    return device.deviceInternal.is_wifi_present()
end

export set_wifi_configuration
"""
    $(SIGNATURES)

Sets the configuration of the WIFI Extension. The ``ssid`` can have a max length
of 32 characters. Possible values for ``connection`` are:

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 90

 "0", "DHCP"
 "1", "Static IP"
 "2", "Access Point: DHCP"
 "3", "Access Point: Static IP"
 "4", "Ad Hoc: DHCP"
 "5", "Ad Hoc: Static IP"

If you set ``connection`` to one of the static IP options then you have to
supply ``ip``, ``subnet_mask`` and ``gateway`` as an array of size 4 (first
element of the array is the least significant byte of the address). If
``connection`` is set to one of the DHCP options then ``ip``, ``subnet_mask``
and ``gateway`` are ignored, you can set them to 0.

The last parameter is the port that your program will connect to.

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

It is recommended to use the Brick Viewer to set the WIFI configuration.
"""
function set_wifi_configuration(device::BrickMaster, ssid, connection, ip, subnet_mask, gateway, port)
    device.deviceInternal.set_wifi_configuration(ssid, connection, ip, subnet_mask, gateway, port)
end

export get_wifi_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Wifi Configuration`.
"""
function get_wifi_configuration(device::BrickMaster)
    return device.deviceInternal.get_wifi_configuration()
end

export set_wifi_encryption
"""
    $(SIGNATURES)

Sets the encryption of the WIFI Extension. The first parameter is the
type of the encryption. Possible values are:

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 90

 "0", "WPA/WPA2"
 "1", "WPA Enterprise (EAP-FAST, EAP-TLS, EAP-TTLS, PEAP)"
 "2", "WEP"
 "3", "No Encryption"

The ``key`` has a max length of 50 characters and is used if ``encryption``
is set to 0 or 2 (WPA/WPA2 or WEP). Otherwise the value is ignored.

For WPA/WPA2 the key has to be at least 8 characters long. If you want to set
a key with more than 50 characters, see :func:`Set Long Wifi Key`.

For WEP the key has to be either 10 or 26 hexadecimal digits long. It is
possible to set the WEP ``key_index`` (1-4). If you don't know your
``key_index``, it is likely 1.

If you choose WPA Enterprise as encryption, you have to set ``eap_options`` and
the length of the certificates (for other encryption types these parameters
are ignored). The certificates
themselves can be set with :func:`Set Wifi Certificate`. ``eap_options`` consist
of the outer authentication (bits 1-2), inner authentication (bit 3) and
certificate type (bits 4-5):

.. csv-table::
 :header: "Option", "Bits", "Description"
 :widths: 20, 10, 70

 "outer authentication", "1-2", "0=EAP-FAST, 1=EAP-TLS, 2=EAP-TTLS, 3=EAP-PEAP"
 "inner authentication", "3", "0=EAP-MSCHAP, 1=EAP-GTC"
 "certificate type", "4-5", "0=CA Certificate, 1=Client Certificate, 2=Private Key"

Example for EAP-TTLS + EAP-GTC + Private Key: ``option = 2 | (1 << 2) | (2 << 3)``.

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

It is recommended to use the Brick Viewer to set the Wi-Fi encryption.
"""
function set_wifi_encryption(device::BrickMaster, encryption, key, key_index, eap_options, ca_certificate_length, client_certificate_length, private_key_length)
    device.deviceInternal.set_wifi_encryption(encryption, key, key_index, eap_options, ca_certificate_length, client_certificate_length, private_key_length)
end

export get_wifi_encryption
"""
    $(SIGNATURES)

Returns the encryption as set by :func:`Set Wifi Encryption`.

.. note::
 Since Master Brick Firmware version 2.4.4 the key is not returned anymore.
"""
function get_wifi_encryption(device::BrickMaster)
    return device.deviceInternal.get_wifi_encryption()
end

export get_wifi_status
"""
    $(SIGNATURES)

Returns the status of the WIFI Extension. The ``state`` is updated automatically,
all of the other parameters are updated on startup and every time
:func:`Refresh Wifi Status` is called.

Possible states are:

.. csv-table::
 :header: "State", "Description"
 :widths: 10, 90

 "0", "Disassociated"
 "1", "Associated"
 "2", "Associating"
 "3", "Error"
 "255", "Not initialized yet"
"""
function get_wifi_status(device::BrickMaster)
    return device.deviceInternal.get_wifi_status()
end

export refresh_wifi_status
"""
    $(SIGNATURES)

Refreshes the Wi-Fi status (see :func:`Get Wifi Status`). To read the status
of the Wi-Fi module, the Master Brick has to change from data mode to
command mode and back. This transaction and the readout itself is
unfortunately time consuming. This means, that it might take some ms
until the stack with attached WIFI Extension reacts again after this
function is called.
"""
function refresh_wifi_status(device::BrickMaster)
    device.deviceInternal.refresh_wifi_status()
end

export set_wifi_certificate
"""
    $(SIGNATURES)

This function is used to set the certificate as well as password and username
for WPA Enterprise. To set the username use index 0xFFFF,
to set the password use index 0xFFFE. The max length of username and
password is 32.

The certificate is written in chunks of size 32 and the index is used as
the index of the chunk. ``data_length`` should nearly always be 32. Only
the last chunk can have a length that is not equal to 32.

The starting index of the CA Certificate is 0, of the Client Certificate
10000 and for the Private Key 20000. Maximum sizes are 1312, 1312 and
4320 byte respectively.

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after uploading the certificate.

It is recommended to use the Brick Viewer to set the certificate, username
and password.
"""
function set_wifi_certificate(device::BrickMaster, index, data, data_length)
    device.deviceInternal.set_wifi_certificate(index, data, data_length)
end

export get_wifi_certificate
"""
    $(SIGNATURES)

Returns the certificate for a given index as set by :func:`Set Wifi Certificate`.
"""
function get_wifi_certificate(device::BrickMaster, index)
    return device.deviceInternal.get_wifi_certificate(index)
end

export set_wifi_power_mode
"""
    $(SIGNATURES)

Sets the power mode of the WIFI Extension. Possible modes are:

.. csv-table::
 :header: "Mode", "Description"
 :widths: 10, 90

 "0", "Full Speed (high power consumption, high throughput)"
 "1", "Low Power (low power consumption, low throughput)"
"""
function set_wifi_power_mode(device::BrickMaster, mode)
    device.deviceInternal.set_wifi_power_mode(mode)
end

export get_wifi_power_mode
"""
    $(SIGNATURES)

Returns the power mode as set by :func:`Set Wifi Power Mode`.
"""
function get_wifi_power_mode(device::BrickMaster)
    return device.deviceInternal.get_wifi_power_mode()
end

export get_wifi_buffer_info
"""
    $(SIGNATURES)

Returns informations about the Wi-Fi receive buffer. The Wi-Fi
receive buffer has a max size of 1500 byte and if data is transfered
too fast, it might overflow.

The return values are the number of overflows, the low watermark
(i.e. the smallest number of bytes that were free in the buffer) and
the bytes that are currently used.

You should always try to keep the buffer empty, otherwise you will
have a permanent latency. A good rule of thumb is, that you can transfer
1000 messages per second without problems.

Try to not send more then 50 messages at a time without any kind of
break between them.
"""
function get_wifi_buffer_info(device::BrickMaster)
    return device.deviceInternal.get_wifi_buffer_info()
end

export set_wifi_regulatory_domain
"""
    $(SIGNATURES)

Sets the regulatory domain of the WIFI Extension. Possible domains are:

.. csv-table::
 :header: "Domain", "Description"
 :widths: 10, 90

 "0", "FCC: Channel 1-11 (N/S America, Australia, New Zealand)"
 "1", "ETSI: Channel 1-13 (Europe, Middle East, Africa)"
 "2", "TELEC: Channel 1-14 (Japan)"
"""
function set_wifi_regulatory_domain(device::BrickMaster, domain)
    device.deviceInternal.set_wifi_regulatory_domain(domain)
end

export get_wifi_regulatory_domain
"""
    $(SIGNATURES)

Returns the regulatory domain as set by :func:`Set Wifi Regulatory Domain`.
"""
function get_wifi_regulatory_domain(device::BrickMaster)
    return device.deviceInternal.get_wifi_regulatory_domain()
end

export get_usb_voltage
"""
    $(SIGNATURES)

Returns the USB voltage. Does not work with hardware version 2.1.
"""
function get_usb_voltage(device::BrickMaster)
    return device.deviceInternal.get_usb_voltage()
end

export set_long_wifi_key
"""
    $(SIGNATURES)

Sets a long Wi-Fi key (up to 63 chars, at least 8 chars) for WPA encryption.
This key will be used
if the key in :func:`Set Wifi Encryption` is set to "-". In the old protocol,
a payload of size 63 was not possible, so the maximum key length was 50 chars.

With the new protocol this is possible, since we didn't want to break API,
this function was added additionally.

.. versionadded:: 2.0.2\$nbsp;(Firmware)
"""
function set_long_wifi_key(device::BrickMaster, key)
    device.deviceInternal.set_long_wifi_key(key)
end

export get_long_wifi_key
"""
    $(SIGNATURES)

Returns the encryption key as set by :func:`Set Long Wifi Key`.

.. note::
 Since Master Brick firmware version 2.4.4 the key is not returned anymore.

.. versionadded:: 2.0.2\$nbsp;(Firmware)
"""
function get_long_wifi_key(device::BrickMaster)
    return device.deviceInternal.get_long_wifi_key()
end

export set_wifi_hostname
"""
    $(SIGNATURES)

Sets the hostname of the WIFI Extension. The hostname will be displayed
by access points as the hostname in the DHCP clients table.

Setting an empty String will restore the default hostname.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_wifi_hostname(device::BrickMaster, hostname)
    device.deviceInternal.set_wifi_hostname(hostname)
end

export get_wifi_hostname
"""
    $(SIGNATURES)

Returns the hostname as set by :func:`Set Wifi Hostname`.

An empty String means, that the default hostname is used.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_wifi_hostname(device::BrickMaster)
    return device.deviceInternal.get_wifi_hostname()
end

export set_stack_current_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Stack Current` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Stack Current` callback is only triggered if the current has changed
since the last triggering.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_stack_current_callback_period(device::BrickMaster, period)
    device.deviceInternal.set_stack_current_callback_period(period)
end

export get_stack_current_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Stack Current Callback Period`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_stack_current_callback_period(device::BrickMaster)
    return device.deviceInternal.get_stack_current_callback_period()
end

export set_stack_voltage_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Stack Voltage` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Stack Voltage` callback is only triggered if the voltage has changed
since the last triggering.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_stack_voltage_callback_period(device::BrickMaster, period)
    device.deviceInternal.set_stack_voltage_callback_period(period)
end

export get_stack_voltage_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Stack Voltage Callback Period`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_stack_voltage_callback_period(device::BrickMaster)
    return device.deviceInternal.get_stack_voltage_callback_period()
end

export set_usb_voltage_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`USB Voltage` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`USB Voltage` callback is only triggered if the voltage has changed
since the last triggering.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_usb_voltage_callback_period(device::BrickMaster, period)
    device.deviceInternal.set_usb_voltage_callback_period(period)
end

export get_usb_voltage_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set USB Voltage Callback Period`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_usb_voltage_callback_period(device::BrickMaster)
    return device.deviceInternal.get_usb_voltage_callback_period()
end

export set_stack_current_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Stack Current Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the current is *outside* the min and max values"
 "'i'",    "Callback is triggered when the current is *inside* the min and max values"
 "'<'",    "Callback is triggered when the current is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the current is greater than the min value (max is ignored)"

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_stack_current_callback_threshold(device::BrickMaster, option, min, max)
    device.deviceInternal.set_stack_current_callback_threshold(option, min, max)
end

export get_stack_current_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Stack Current Callback Threshold`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_stack_current_callback_threshold(device::BrickMaster)
    return device.deviceInternal.get_stack_current_callback_threshold()
end

export set_stack_voltage_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Stack Voltage Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the voltage is *outside* the min and max values"
 "'i'",    "Callback is triggered when the voltage is *inside* the min and max values"
 "'<'",    "Callback is triggered when the voltage is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the voltage is greater than the min value (max is ignored)"

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_stack_voltage_callback_threshold(device::BrickMaster, option, min, max)
    device.deviceInternal.set_stack_voltage_callback_threshold(option, min, max)
end

export get_stack_voltage_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Stack Voltage Callback Threshold`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_stack_voltage_callback_threshold(device::BrickMaster)
    return device.deviceInternal.get_stack_voltage_callback_threshold()
end

export set_usb_voltage_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`USB Voltage Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the voltage is *outside* the min and max values"
 "'i'",    "Callback is triggered when the voltage is *inside* the min and max values"
 "'<'",    "Callback is triggered when the voltage is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the voltage is greater than the min value (max is ignored)"

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_usb_voltage_callback_threshold(device::BrickMaster, option, min, max)
    device.deviceInternal.set_usb_voltage_callback_threshold(option, min, max)
end

export get_usb_voltage_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set USB Voltage Callback Threshold`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_usb_voltage_callback_threshold(device::BrickMaster)
    return device.deviceInternal.get_usb_voltage_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Stack Current Reached`,
* :cb:`Stack Voltage Reached`,
* :cb:`USB Voltage Reached`

are triggered, if the thresholds

* :func:`Set Stack Current Callback Threshold`,
* :func:`Set Stack Voltage Callback Threshold`,
* :func:`Set USB Voltage Callback Threshold`

keep being reached.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_debounce_period(device::BrickMaster, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_debounce_period(device::BrickMaster)
    return device.deviceInternal.get_debounce_period()
end

export is_ethernet_present
"""
    $(SIGNATURES)

Returns *true* if the Master Brick is at position 0 in the stack and an Ethernet
Extension is available.

.. versionadded:: 2.1.0\$nbsp;(Firmware)
"""
function is_ethernet_present(device::BrickMaster)
    return device.deviceInternal.is_ethernet_present()
end

export set_ethernet_configuration
"""
    $(SIGNATURES)

Sets the configuration of the Ethernet Extension. Possible values for
``connection`` are:

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 90

 "0", "DHCP"
 "1", "Static IP"

If you set ``connection`` to static IP options then you have to supply ``ip``,
``subnet_mask`` and ``gateway`` as an array of size 4 (first element of the
array is the least significant byte of the address). If ``connection`` is set
to the DHCP options then ``ip``, ``subnet_mask`` and ``gateway`` are ignored,
you can set them to 0.

The last parameter is the port that your program will connect to.

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

It is recommended to use the Brick Viewer to set the Ethernet configuration.

.. versionadded:: 2.1.0\$nbsp;(Firmware)
"""
function set_ethernet_configuration(device::BrickMaster, connection, ip, subnet_mask, gateway, port)
    device.deviceInternal.set_ethernet_configuration(connection, ip, subnet_mask, gateway, port)
end

export get_ethernet_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Ethernet Configuration`.

.. versionadded:: 2.1.0\$nbsp;(Firmware)
"""
function get_ethernet_configuration(device::BrickMaster)
    return device.deviceInternal.get_ethernet_configuration()
end

export get_ethernet_status
"""
    $(SIGNATURES)

Returns the status of the Ethernet Extension.

``mac_address``, ``ip``, ``subnet_mask`` and ``gateway`` are given as an array.
The first element of the array is the least significant byte of the address.

``rx_count`` and ``tx_count`` are the number of bytes that have been
received/send since last restart.

``hostname`` is the currently used hostname.

.. versionadded:: 2.1.0\$nbsp;(Firmware)
"""
function get_ethernet_status(device::BrickMaster)
    return device.deviceInternal.get_ethernet_status()
end

export set_ethernet_hostname
"""
    $(SIGNATURES)

Sets the hostname of the Ethernet Extension. The hostname will be displayed
by access points as the hostname in the DHCP clients table.

Setting an empty String will restore the default hostname.

The current hostname can be discovered with :func:`Get Ethernet Status`.

.. versionadded:: 2.1.0\$nbsp;(Firmware)
"""
function set_ethernet_hostname(device::BrickMaster, hostname)
    device.deviceInternal.set_ethernet_hostname(hostname)
end

export set_ethernet_mac_address
"""
    $(SIGNATURES)

Sets the MAC address of the Ethernet Extension. The Ethernet Extension should
come configured with a valid MAC address, that is also written on a
sticker of the extension itself.

The MAC address can be read out again with :func:`Get Ethernet Status`.

.. versionadded:: 2.1.0\$nbsp;(Firmware)
"""
function set_ethernet_mac_address(device::BrickMaster, mac_address)
    device.deviceInternal.set_ethernet_mac_address(mac_address)
end

export set_ethernet_websocket_configuration
"""
    $(SIGNATURES)

Sets the Ethernet WebSocket configuration. The first parameter sets the number of socket
connections that are reserved for WebSockets. The range is 0-7. The connections
are shared with the plain sockets. Example: If you set the connections to 3,
there will be 3 WebSocket and 4 plain socket connections available.

The second parameter is the port for the WebSocket connections. The port can
not be the same as the port for the plain socket connections.

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

It is recommended to use the Brick Viewer to set the Ethernet configuration.

.. versionadded:: 2.2.0\$nbsp;(Firmware)
"""
function set_ethernet_websocket_configuration(device::BrickMaster, sockets, port)
    device.deviceInternal.set_ethernet_websocket_configuration(sockets, port)
end

export get_ethernet_websocket_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Ethernet Configuration`.

.. versionadded:: 2.2.0\$nbsp;(Firmware)
"""
function get_ethernet_websocket_configuration(device::BrickMaster)
    return device.deviceInternal.get_ethernet_websocket_configuration()
end

export set_ethernet_authentication_secret
"""
    $(SIGNATURES)

Sets the Ethernet authentication secret. The secret can be a string of up to 64
characters. An empty string disables the authentication.

See the :ref:`authentication tutorial <tutorial_authentication>` for more
information.

The secret is stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

It is recommended to use the Brick Viewer to set the Ethernet authentication secret.

The default value is an empty string (authentication disabled).

.. versionadded:: 2.2.0\$nbsp;(Firmware)
"""
function set_ethernet_authentication_secret(device::BrickMaster, secret)
    device.deviceInternal.set_ethernet_authentication_secret(secret)
end

export get_ethernet_authentication_secret
"""
    $(SIGNATURES)

Returns the authentication secret as set by
:func:`Set Ethernet Authentication Secret`.

.. versionadded:: 2.2.0\$nbsp;(Firmware)
"""
function get_ethernet_authentication_secret(device::BrickMaster)
    return device.deviceInternal.get_ethernet_authentication_secret()
end

export set_wifi_authentication_secret
"""
    $(SIGNATURES)

Sets the WIFI authentication secret. The secret can be a string of up to 64
characters. An empty string disables the authentication.

See the :ref:`authentication tutorial <tutorial_authentication>` for more
information.

The secret is stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

It is recommended to use the Brick Viewer to set the WIFI authentication secret.

The default value is an empty string (authentication disabled).

.. versionadded:: 2.2.0\$nbsp;(Firmware)
"""
function set_wifi_authentication_secret(device::BrickMaster, secret)
    device.deviceInternal.set_wifi_authentication_secret(secret)
end

export get_wifi_authentication_secret
"""
    $(SIGNATURES)

Returns the authentication secret as set by
:func:`Set Wifi Authentication Secret`.

.. versionadded:: 2.2.0\$nbsp;(Firmware)
"""
function get_wifi_authentication_secret(device::BrickMaster)
    return device.deviceInternal.get_wifi_authentication_secret()
end

export get_connection_type
"""
    $(SIGNATURES)

Returns the type of the connection over which this function was called.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_connection_type(device::BrickMaster)
    return device.deviceInternal.get_connection_type()
end

export is_wifi2_present
"""
    $(SIGNATURES)

Returns *true* if the Master Brick is at position 0 in the stack and a WIFI
Extension 2.0 is available.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function is_wifi2_present(device::BrickMaster)
    return device.deviceInternal.is_wifi2_present()
end

export start_wifi2_bootloader
"""
    $(SIGNATURES)

Starts the bootloader of the WIFI Extension 2.0. Returns 0 on success.
Afterwards the :func:`Write Wifi2 Serial Port` and :func:`Read Wifi2 Serial Port`
functions can be used to communicate with the bootloader to flash a new
firmware.

The bootloader should only be started over a USB connection. It cannot be
started over a WIFI2 connection, see the :func:`Get Connection Type` function.

It is recommended to use the Brick Viewer to update the firmware of the WIFI
Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function start_wifi2_bootloader(device::BrickMaster)
    return device.deviceInternal.start_wifi2_bootloader()
end

export write_wifi2_serial_port
"""
    $(SIGNATURES)

Writes up to 60 bytes (number of bytes to be written specified by ``length``)
to the serial port of the bootloader of the WIFI Extension 2.0. Returns 0 on
success.

Before this function can be used the bootloader has to be started using the
:func:`Start Wifi2 Bootloader` function.

It is recommended to use the Brick Viewer to update the firmware of the WIFI
Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function write_wifi2_serial_port(device::BrickMaster, data, length)
    return device.deviceInternal.write_wifi2_serial_port(data, length)
end

export read_wifi2_serial_port
"""
    $(SIGNATURES)

Reads up to 60 bytes (number of bytes to be read specified by ``length``)
from the serial port of the bootloader of the WIFI Extension 2.0.
Returns the number of actually read bytes.

Before this function can be used the bootloader has to be started using the
:func:`Start Wifi2 Bootloader` function.

It is recommended to use the Brick Viewer to update the firmware of the WIFI
Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function read_wifi2_serial_port(device::BrickMaster, length)
    return device.deviceInternal.read_wifi2_serial_port(length)
end

export set_wifi2_authentication_secret
"""
    $(SIGNATURES)

Sets the WIFI authentication secret. The secret can be a string of up to 64
characters. An empty string disables the authentication. The default value is
an empty string (authentication disabled).

See the :ref:`authentication tutorial <tutorial_authentication>` for more
information.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_authentication_secret(device::BrickMaster, secret)
    device.deviceInternal.set_wifi2_authentication_secret(secret)
end

export get_wifi2_authentication_secret
"""
    $(SIGNATURES)

Returns the WIFI authentication secret as set by
:func:`Set Wifi2 Authentication Secret`.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_authentication_secret(device::BrickMaster)
    return device.deviceInternal.get_wifi2_authentication_secret()
end

export set_wifi2_configuration
"""
    $(SIGNATURES)

Sets the general configuration of the WIFI Extension 2.0.

The ``port`` parameter sets the port number that your programm will connect
to.

The ``websocket_port`` parameter sets the WebSocket port number that your
JavaScript programm will connect to.

The ``website_port`` parameter sets the port number for the website of the
WIFI Extension 2.0.

The ``phy_mode`` parameter sets the specific wireless network mode to be used.
Possible values are B, G and N.

The ``sleep_mode`` parameter is currently unused.

The ``website`` parameter is used to enable or disable the web interface of
the WIFI Extension 2.0, which is available from firmware version 2.0.1. Note
that, for firmware version 2.0.3 and older, to disable the the web interface
the ``website_port`` parameter must be set to 1 and greater than 1 to enable
the web interface. For firmware version 2.0.4 and later, setting this parameter
to 1 will enable the web interface and setting it to 0 will disable the web
interface.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_configuration(device::BrickMaster, port, websocket_port, website_port, phy_mode, sleep_mode, website)
    device.deviceInternal.set_wifi2_configuration(port, websocket_port, website_port, phy_mode, sleep_mode, website)
end

export get_wifi2_configuration
"""
    $(SIGNATURES)

Returns the general configuration as set by :func:`Set Wifi2 Configuration`.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_configuration(device::BrickMaster)
    return device.deviceInternal.get_wifi2_configuration()
end

export get_wifi2_status
"""
    $(SIGNATURES)

Returns the client and access point status of the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_status(device::BrickMaster)
    return device.deviceInternal.get_wifi2_status()
end

export set_wifi2_client_configuration
"""
    $(SIGNATURES)

Sets the client specific configuration of the WIFI Extension 2.0.

The ``enable`` parameter enables or disables the client part of the
WIFI Extension 2.0.

The ``ssid`` parameter sets the SSID (up to 32 characters) of the access point
to connect to.

If the ``ip`` parameter is set to all zero then ``subnet_mask`` and ``gateway``
parameters are also set to all zero and DHCP is used for IP address configuration.
Otherwise those three parameters can be used to configure a static IP address.
The default configuration is DHCP.

If the ``mac_address`` parameter is set to all zero then the factory MAC
address is used. Otherwise this parameter can be used to set a custom MAC
address.

If the ``bssid`` parameter is set to all zero then WIFI Extension 2.0 will
connect to any access point that matches the configured SSID. Otherwise this
parameter can be used to make the WIFI Extension 2.0 only connect to an
access point if SSID and BSSID match.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_client_configuration(device::BrickMaster, enable, ssid, ip, subnet_mask, gateway, mac_address, bssid)
    device.deviceInternal.set_wifi2_client_configuration(enable, ssid, ip, subnet_mask, gateway, mac_address, bssid)
end

export get_wifi2_client_configuration
"""
    $(SIGNATURES)

Returns the client configuration as set by :func:`Set Wifi2 Client Configuration`.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_client_configuration(device::BrickMaster)
    return device.deviceInternal.get_wifi2_client_configuration()
end

export set_wifi2_client_hostname
"""
    $(SIGNATURES)

Sets the client hostname (up to 32 characters) of the WIFI Extension 2.0. The
hostname will be displayed by access points as the hostname in the DHCP clients
table.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_client_hostname(device::BrickMaster, hostname)
    device.deviceInternal.set_wifi2_client_hostname(hostname)
end

export get_wifi2_client_hostname
"""
    $(SIGNATURES)

Returns the client hostname as set by :func:`Set Wifi2 Client Hostname`.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_client_hostname(device::BrickMaster)
    return device.deviceInternal.get_wifi2_client_hostname()
end

export set_wifi2_client_password
"""
    $(SIGNATURES)

Sets the client password (up to 63 chars) for WPA/WPA2 encryption.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_client_password(device::BrickMaster, password)
    device.deviceInternal.set_wifi2_client_password(password)
end

export get_wifi2_client_password
"""
    $(SIGNATURES)

Returns the client password as set by :func:`Set Wifi2 Client Password`.

.. note::
 Since WIFI Extension 2.0 firmware version 2.1.3 the password is not
 returned anymore.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_client_password(device::BrickMaster)
    return device.deviceInternal.get_wifi2_client_password()
end

export set_wifi2_ap_configuration
"""
    $(SIGNATURES)

Sets the access point specific configuration of the WIFI Extension 2.0.

The ``enable`` parameter enables or disables the access point part of the
WIFI Extension 2.0.

The ``ssid`` parameter sets the SSID (up to 32 characters) of the access point.

If the ``ip`` parameter is set to all zero then ``subnet_mask`` and ``gateway``
parameters are also set to all zero and DHCP is used for IP address configuration.
Otherwise those three parameters can be used to configure a static IP address.
The default configuration is DHCP.

The ``encryption`` parameter sets the encryption mode to be used. Possible
values are Open (no encryption), WEP or WPA/WPA2 PSK.
Use the :func:`Set Wifi2 AP Password` function to set the encryption
password.

The ``hidden`` parameter makes the access point hide or show its SSID.

The ``channel`` parameter sets the channel (1 to 13) of the access point.

If the ``mac_address`` parameter is set to all zero then the factory MAC
address is used. Otherwise this parameter can be used to set a custom MAC
address.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_ap_configuration(device::BrickMaster, enable, ssid, ip, subnet_mask, gateway, encryption, hidden, channel, mac_address)
    device.deviceInternal.set_wifi2_ap_configuration(enable, ssid, ip, subnet_mask, gateway, encryption, hidden, channel, mac_address)
end

export get_wifi2_ap_configuration
"""
    $(SIGNATURES)

Returns the access point configuration as set by :func:`Set Wifi2 AP Configuration`.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_ap_configuration(device::BrickMaster)
    return device.deviceInternal.get_wifi2_ap_configuration()
end

export set_wifi2_ap_password
"""
    $(SIGNATURES)

Sets the access point password (at least 8 and up to 63 chars) for the configured encryption
mode, see :func:`Set Wifi2 AP Configuration`.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function set_wifi2_ap_password(device::BrickMaster, password)
    device.deviceInternal.set_wifi2_ap_password(password)
end

export get_wifi2_ap_password
"""
    $(SIGNATURES)

Returns the access point password as set by :func:`Set Wifi2 AP Password`.

.. note::
 Since WIFI Extension 2.0 firmware version 2.1.3 the password is not
 returned anymore.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_ap_password(device::BrickMaster)
    return device.deviceInternal.get_wifi2_ap_password()
end

export save_wifi2_configuration
"""
    $(SIGNATURES)

All configuration functions for the WIFI Extension 2.0 do not change the
values permanently. After configuration this function has to be called to
permanently store the values.

The values are stored in the EEPROM and only applied on startup. That means
you have to restart the Master Brick after configuration.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function save_wifi2_configuration(device::BrickMaster)
    return device.deviceInternal.save_wifi2_configuration()
end

export get_wifi2_firmware_version
"""
    $(SIGNATURES)

Returns the current version of the WIFI Extension 2.0 firmware.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function get_wifi2_firmware_version(device::BrickMaster)
    return device.deviceInternal.get_wifi2_firmware_version()
end

export enable_wifi2_status_led
"""
    $(SIGNATURES)

Turns the green status LED of the WIFI Extension 2.0 on.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function enable_wifi2_status_led(device::BrickMaster)
    device.deviceInternal.enable_wifi2_status_led()
end

export disable_wifi2_status_led
"""
    $(SIGNATURES)

Turns the green status LED of the WIFI Extension 2.0 off.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function disable_wifi2_status_led(device::BrickMaster)
    device.deviceInternal.disable_wifi2_status_led()
end

export is_wifi2_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the green status LED of the WIFI Extension 2.0 is turned on.

.. versionadded:: 2.4.0\$nbsp;(Firmware)
"""
function is_wifi2_status_led_enabled(device::BrickMaster)
    return device.deviceInternal.is_wifi2_status_led_enabled()
end

export set_wifi2_mesh_configuration
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Sets the mesh specific configuration of the WIFI Extension 2.0.

The ``enable`` parameter enables or disables the mesh part of the
WIFI Extension 2.0. The mesh part cannot be
enabled together with the client and access-point part.

If the ``root_ip`` parameter is set to all zero then ``root_subnet_mask``
and ``root_gateway`` parameters are also set to all zero and DHCP is used for
IP address configuration. Otherwise those three parameters can be used to
configure a static IP address. The default configuration is DHCP.

If the ``router_bssid`` parameter is set to all zero then the information is
taken from Wi-Fi scan when connecting the SSID as set by
:func:`Set Wifi2 Mesh Router SSID`. This only works if the the SSID is not hidden.
In case the router has hidden SSID this parameter must be specified, otherwise
the node will not be able to reach the mesh router.

The ``group_id`` and the ``group_ssid_prefix`` parameters identifies a
particular mesh network and nodes configured with same ``group_id`` and the
``group_ssid_prefix`` are considered to be in the same mesh network.

The ``gateway_ip`` and the ``gateway_port`` parameters specifies the location
of the brickd that supports mesh feature.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function set_wifi2_mesh_configuration(device::BrickMaster, enable, root_ip, root_subnet_mask, root_gateway, router_bssid, group_id, group_ssid_prefix, gateway_ip, gateway_port)
    device.deviceInternal.set_wifi2_mesh_configuration(enable, root_ip, root_subnet_mask, root_gateway, router_bssid, group_id, group_ssid_prefix, gateway_ip, gateway_port)
end

export get_wifi2_mesh_configuration
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Returns the mesh configuration as set by :func:`Set Wifi2 Mesh Configuration`.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function get_wifi2_mesh_configuration(device::BrickMaster)
    return device.deviceInternal.get_wifi2_mesh_configuration()
end

export set_wifi2_mesh_router_ssid
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Sets the mesh router SSID of the WIFI Extension 2.0.
It is used to specify the mesh router to connect to.

Note that even though in the argument of this function a 32 characters long SSID
is allowed, in practice valid SSID should have a maximum of 31 characters. This
is due to a bug in the mesh library that we use in the firmware of the extension.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function set_wifi2_mesh_router_ssid(device::BrickMaster, ssid)
    device.deviceInternal.set_wifi2_mesh_router_ssid(ssid)
end

export get_wifi2_mesh_router_ssid
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Returns the mesh router SSID as set by :func:`Set Wifi2 Mesh Router SSID`.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function get_wifi2_mesh_router_ssid(device::BrickMaster)
    return device.deviceInternal.get_wifi2_mesh_router_ssid()
end

export set_wifi2_mesh_router_password
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Sets the mesh router password (up to 64 characters) for WPA/WPA2 encryption.
The password will be used to connect to the mesh router.

To apply configuration changes to the WIFI Extension 2.0 the
:func:`Save Wifi2 Configuration` function has to be called and the Master Brick
has to be restarted afterwards.

It is recommended to use the Brick Viewer to configure the WIFI Extension 2.0.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function set_wifi2_mesh_router_password(device::BrickMaster, password)
    device.deviceInternal.set_wifi2_mesh_router_password(password)
end

export get_wifi2_mesh_router_password
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Returns the mesh router password as set by :func:`Set Wifi2 Mesh Router Password`.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function get_wifi2_mesh_router_password(device::BrickMaster)
    return device.deviceInternal.get_wifi2_mesh_router_password()
end

export get_wifi2_mesh_common_status
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Returns the common mesh status of the WIFI Extension 2.0.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function get_wifi2_mesh_common_status(device::BrickMaster)
    return device.deviceInternal.get_wifi2_mesh_common_status()
end

export get_wifi2_mesh_client_status
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Returns the mesh client status of the WIFI Extension 2.0.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function get_wifi2_mesh_client_status(device::BrickMaster)
    return device.deviceInternal.get_wifi2_mesh_client_status()
end

export get_wifi2_mesh_ap_status
"""
    $(SIGNATURES)

Requires WIFI Extension 2.0 firmware 2.1.0.

Returns the mesh AP status of the WIFI Extension 2.0.

.. versionadded:: 2.4.2\$nbsp;(Firmware)
"""
function get_wifi2_mesh_ap_status(device::BrickMaster)
    return device.deviceInternal.get_wifi2_mesh_ap_status()
end

export set_bricklet_xmc_flash_config
"""
    $(SIGNATURES)

This function is for internal use to flash the initial
bootstrapper and bootloader to the Bricklets.

If you need to flash a boostrapper/bootloader (for exmaple
because you made your own Bricklet from scratch) please
take a look at our open source flash and test tool at
`https://github.com/Tinkerforge/flash-test <https://github.com/Tinkerforge/flash-test>`__

Don't use this function directly.

.. versionadded:: 2.5.0\$nbsp;(Firmware)
"""
function set_bricklet_xmc_flash_config(device::BrickMaster, config, parameter1, parameter2, data)
    return device.deviceInternal.set_bricklet_xmc_flash_config(config, parameter1, parameter2, data)
end

export set_bricklet_xmc_flash_data
"""
    $(SIGNATURES)

This function is for internal use to flash the initial
bootstrapper and bootloader to the Bricklets.

If you need to flash a boostrapper/bootloader (for exmaple
because you made your own Bricklet from scratch) please
take a look at our open source flash and test tool at
`https://github.com/Tinkerforge/flash-test <https://github.com/Tinkerforge/flash-test>`__

Don't use this function directly.

.. versionadded:: 2.5.0\$nbsp;(Firmware)
"""
function set_bricklet_xmc_flash_data(device::BrickMaster, data)
    return device.deviceInternal.set_bricklet_xmc_flash_data(data)
end

export set_bricklets_enabled
"""
    $(SIGNATURES)

This function is only available in Master Brick hardware version >= 3.0.

Enables/disables all four Bricklets if set to true/false.

If you disable the Bricklets the power supply to the Bricklets will be disconnected.
The Bricklets will lose all configurations if disabled.

.. versionadded:: 2.5.0\$nbsp;(Firmware)
"""
function set_bricklets_enabled(device::BrickMaster, bricklets_enabled)
    device.deviceInternal.set_bricklets_enabled(bricklets_enabled)
end

export get_bricklets_enabled
"""
    $(SIGNATURES)

Returns *true* if the Bricklets are enabled, *false* otherwise.

.. versionadded:: 2.5.0\$nbsp;(Firmware)
"""
function get_bricklets_enabled(device::BrickMaster)
    return device.deviceInternal.get_bricklets_enabled()
end

export set_spitfp_baudrate_config
"""
    $(SIGNATURES)

The SPITF protocol can be used with a dynamic baudrate. If the dynamic baudrate is
enabled, the Brick will try to adapt the baudrate for the communication
between Bricks and Bricklets according to the amount of data that is transferred.

The baudrate will be increased exponentially if lots of data is sent/received and
decreased linearly if little data is sent/received.

This lowers the baudrate in applications where little data is transferred (e.g.
a weather station) and increases the robustness. If there is lots of data to transfer
(e.g. Thermal Imaging Bricklet) it automatically increases the baudrate as needed.

In cases where some data has to transferred as fast as possible every few seconds
(e.g. RS485 Bricklet with a high baudrate but small payload) you may want to turn
the dynamic baudrate off to get the highest possible performance.

The maximum value of the baudrate can be set per port with the function
:func:`Set SPITFP Baudrate`. If the dynamic baudrate is disabled, the baudrate
as set by :func:`Set SPITFP Baudrate` will be used statically.

.. versionadded:: 2.4.6\$nbsp;(Firmware)
"""
function set_spitfp_baudrate_config(device::BrickMaster, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.

.. versionadded:: 2.4.6\$nbsp;(Firmware)
"""
function get_spitfp_baudrate_config(device::BrickMaster)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export get_send_timeout_count
"""
    $(SIGNATURES)

Returns the timeout count for the different communication methods.

The methods 0-2 are available for all Bricks, 3-7 only for Master Bricks.

This function is mostly used for debugging during development, in normal operation
the counters should nearly always stay at 0.

.. versionadded:: 2.4.3\$nbsp;(Firmware)
"""
function get_send_timeout_count(device::BrickMaster, communication_method)
    return device.deviceInternal.get_send_timeout_count(communication_method)
end

export set_spitfp_baudrate
"""
    $(SIGNATURES)

Sets the baudrate for a specific Bricklet port.

If you want to increase the throughput of Bricklets you can increase
the baudrate. If you get a high error count because of high
interference (see :func:`Get SPITFP Error Count`) you can decrease the
baudrate.

If the dynamic baudrate feature is enabled, the baudrate set by this
function corresponds to the maximum baudrate (see :func:`Set SPITFP Baudrate Config`).

Regulatory testing is done with the default baudrate. If CE compatibility
or similar is necessary in your applications we recommend to not change
the baudrate.

.. versionadded:: 2.4.3\$nbsp;(Firmware)
"""
function set_spitfp_baudrate(device::BrickMaster, bricklet_port, baudrate)
    device.deviceInternal.set_spitfp_baudrate(bricklet_port, baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate for a given Bricklet port, see :func:`Set SPITFP Baudrate`.

.. versionadded:: 2.4.3\$nbsp;(Firmware)
"""
function get_spitfp_baudrate(device::BrickMaster, bricklet_port)
    return device.deviceInternal.get_spitfp_baudrate(bricklet_port)
end

export get_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Brick and Bricklet.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.

The errors counts are for errors that occur on the Brick side. All
Bricklets have a similar function that returns the errors on the Bricklet side.

.. versionadded:: 2.4.3\$nbsp;(Firmware)
"""
function get_spitfp_error_count(device::BrickMaster, bricklet_port)
    return device.deviceInternal.get_spitfp_error_count(bricklet_port)
end

export enable_status_led
"""
    $(SIGNATURES)

Enables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function enable_status_led(device::BrickMaster)
    device.deviceInternal.enable_status_led()
end

export disable_status_led
"""
    $(SIGNATURES)

Disables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function disable_status_led(device::BrickMaster)
    device.deviceInternal.disable_status_led()
end

export is_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the status LED is enabled, *false* otherwise.

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function is_status_led_enabled(device::BrickMaster)
    return device.deviceInternal.is_status_led_enabled()
end

export get_protocol1_bricklet_name
"""
    $(SIGNATURES)

Returns the firmware and protocol version and the name of the Bricklet for a
given port.

This functions sole purpose is to allow automatic flashing of v1.x.y Bricklet
plugins.
"""
function get_protocol1_bricklet_name(device::BrickMaster, port)
    return device.deviceInternal.get_protocol1_bricklet_name(port)
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has an
accuracy of ±15%. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickMaster)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Brick. Calling this function
on a Brick inside of a stack will reset the whole stack.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickMaster)
    device.deviceInternal.reset()
end

export write_bricklet_plugin
"""
    $(SIGNATURES)

Writes 32 bytes of firmware to the bricklet attached at the given port.
The bytes are written to the position offset * 32.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_bricklet_plugin(device::BrickMaster, port, offset, chunk)
    device.deviceInternal.write_bricklet_plugin(port, offset, chunk)
end

export read_bricklet_plugin
"""
    $(SIGNATURES)

Reads 32 bytes of firmware from the bricklet attached at the given port.
The bytes are read starting at the position offset * 32.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function read_bricklet_plugin(device::BrickMaster, port, offset)
    return device.deviceInternal.read_bricklet_plugin(port, offset)
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Brick is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position is the position in the stack from '0' (bottom) to '8' (top).

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickMaster)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickMaster, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
