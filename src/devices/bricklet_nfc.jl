


export BrickletNFCReaderGetTagIDLowLevel
struct BrickletNFCReaderGetTagIDLowLevel
    tag_type::Integer
    tag_id_length::Integer
    tag_id_data::Vector{Integer}
end

export BrickletNFCReaderGetState
struct BrickletNFCReaderGetState
    state::Integer
    idle::Bool
end

export BrickletNFCReaderReadNDEFLowLevel
struct BrickletNFCReaderReadNDEFLowLevel
    ndef_length::Integer
    ndef_chunk_offset::Integer
    ndef_chunk_data::Vector{Integer}
end

export BrickletNFCReaderReadPageLowLevel
struct BrickletNFCReaderReadPageLowLevel
    data_length::Integer
    data_chunk_offset::Integer
    data_chunk_data::Vector{Integer}
end

export BrickletNFCCardemuGetState
struct BrickletNFCCardemuGetState
    state::Integer
    idle::Bool
end

export BrickletNFCP2PGetState
struct BrickletNFCP2PGetState
    state::Integer
    idle::Bool
end

export BrickletNFCP2PReadNDEFLowLevel
struct BrickletNFCP2PReadNDEFLowLevel
    ndef_length::Integer
    ndef_chunk_offset::Integer
    ndef_chunk_data::Vector{Integer}
end

export BrickletNFCSimpleGetTagIDLowLevel
struct BrickletNFCSimpleGetTagIDLowLevel
    tag_type::Integer
    tag_id_length::Integer
    tag_id_data::Vector{Integer}
    last_seen::Integer
end

export BrickletNFCSPITFPErrorCount
struct BrickletNFCSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletNFCIdentity
struct BrickletNFCIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletNFCReaderGetTagID
struct BrickletNFCReaderGetTagID
    tag_type::Integer
    tag_id::Vector{Integer}
end

export BrickletNFCSimpleGetTagID
struct BrickletNFCSimpleGetTagID
    tag_type::Integer
    tag_id::Vector{Integer}
    last_seen::Integer
end

export BrickletNFC
"""
NFC tag read/write, NFC P2P and Card Emulation
"""
mutable struct BrickletNFC <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletNFC(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_nfc")
        deviceInternal = package.BrickletNFC(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_mode
"""
    $(SIGNATURES)

Sets the mode. The NFC Bricklet supports four modes:

* Off
* Card Emulation (Cardemu): Emulates a tag for other readers
* Peer to Peer (P2P): Exchange data with other readers
* Reader: Reads and writes tags

If you change a mode, the Bricklet will reconfigure the hardware for this mode.
Therefore, you can only use functions corresponding to the current mode. For
example, in Reader mode you can only use Reader functions.
"""
function set_mode(device::BrickletNFC, mode)
    device.deviceInternal.set_mode(mode)
end

export get_mode
"""
    $(SIGNATURES)

Returns the mode as set by :func:`Set Mode`.
"""
function get_mode(device::BrickletNFC)
    return device.deviceInternal.get_mode()
end

export reader_request_tag_id
"""
    $(SIGNATURES)

After you call :func:`Reader Request Tag ID` the NFC Bricklet will try to read
the tag ID from the tag. After this process is done the state will change.
You can either register the :cb:`Reader State Changed` callback or you can poll
:func:`Reader Get State` to find out about the state change.

If the state changes to *ReaderRequestTagIDError* it means that either there was
no tag present or that the tag has an incompatible type. If the state
changes to *ReaderRequestTagIDReady* it means that a compatible tag was found
and that the tag ID has been saved. You can now read out the tag ID by
calling :func:`Reader Get Tag ID`.

If two tags are in the proximity of the NFC Bricklet, this
function will cycle through the tags. To select a specific tag you have
to call :func:`Reader Request Tag ID` until the correct tag ID is found.

In case of any *ReaderError* state the selection is lost and you have to
start again by calling :func:`Reader Request Tag ID`.
"""
function reader_request_tag_id(device::BrickletNFC)
    device.deviceInternal.reader_request_tag_id()
end

export reader_get_tag_id_low_level
"""
    $(SIGNATURES)

Returns the tag type and the tag ID. This function can only be called if the
NFC Bricklet is currently in one of the *ReaderReady* states. The returned tag ID
is the tag ID that was saved through the last call of :func:`Reader Request Tag ID`.

To get the tag ID of a tag the approach is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see :func:`Reader Get State` or
   :cb:`Reader State Changed` callback)
3. Call :func:`Reader Get Tag ID`
"""
function reader_get_tag_id_low_level(device::BrickletNFC)
    return device.deviceInternal.reader_get_tag_id_low_level()
end

export reader_get_state
"""
    $(SIGNATURES)

Returns the current reader state of the NFC Bricklet.

On startup the Bricklet will be in the *ReaderInitialization* state. The
initialization will only take about 20ms. After that it changes to *ReaderIdle*.

The Bricklet is also reinitialized if the mode is changed, see :func:`Set Mode`.

The functions of this Bricklet can be called in the *ReaderIdle* state and all of
the *ReaderReady* and *ReaderError* states.

Example: If you call :func:`Reader Request Page`, the state will change to
*ReaderRequestPage* until the reading of the page is finished. Then it will change
to either *ReaderRequestPageReady* if it worked or to *ReaderRequestPageError* if it
didn't. If the request worked you can get the page by calling :func:`Reader Read Page`.

The same approach is used analogously for the other API functions.
"""
function reader_get_state(device::BrickletNFC)
    return device.deviceInternal.reader_get_state()
end

export reader_write_ndef_low_level
"""
    $(SIGNATURES)

Writes NDEF formated data.

This function currently supports NFC Forum Type 2 and 4.

The general approach for writing a NDEF message is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see
   :func:`Reader Get State` or :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check
   if the expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Write NDEF` with the NDEF message that you want to write
5. Wait for state to change to *ReaderWriteNDEFReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
"""
function reader_write_ndef_low_level(device::BrickletNFC, ndef_length, ndef_chunk_offset, ndef_chunk_data)
    device.deviceInternal.reader_write_ndef_low_level(ndef_length, ndef_chunk_offset, ndef_chunk_data)
end

export reader_request_ndef
"""
    $(SIGNATURES)

Reads NDEF formated data from a tag.

This function currently supports NFC Forum Type 1, 2, 3 and 4.

The general approach for reading a NDEF message is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *RequestTagIDReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Request NDEF`
5. Wait for state to change to *ReaderRequestNDEFReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
6. Call :func:`Reader Read NDEF` to retrieve the NDEF message from the buffer
"""
function reader_request_ndef(device::BrickletNFC)
    device.deviceInternal.reader_request_ndef()
end

export reader_read_ndef_low_level
"""
    $(SIGNATURES)

Returns the NDEF data from an internal buffer. To fill the buffer
with a NDEF message you have to call :func:`Reader Request NDEF` beforehand.
"""
function reader_read_ndef_low_level(device::BrickletNFC)
    return device.deviceInternal.reader_read_ndef_low_level()
end

export reader_authenticate_mifare_classic_page
"""
    $(SIGNATURES)

Mifare Classic tags use authentication. If you want to read from or write to
a Mifare Classic page you have to authenticate it beforehand.
Each page can be authenticated with two keys: A (``key_number`` = 0) and B
(``key_number`` = 1). A new Mifare Classic
tag that has not yet been written to can be accessed with key A
and the default key ``[0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]``.

The approach to read or write a Mifare Classic page is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Authenticate Mifare Classic Page` with page and key for the page
5. Wait for state to change to *ReaderAuthenticatingMifareClassicPageReady* (see
   :func:`Reader Get State` or :cb:`Reader State Changed` callback)
6. Call :func:`Reader Request Page` or :func:`Reader Write Page` to read/write page

The authentication will always work for one whole sector (4 pages).
"""
function reader_authenticate_mifare_classic_page(device::BrickletNFC, page, key_number, key)
    device.deviceInternal.reader_authenticate_mifare_classic_page(page, key_number, key)
end

export reader_write_page_low_level
"""
    $(SIGNATURES)

Writes a maximum of 8192 bytes starting from the given page. How many pages are written
depends on the tag type. The page sizes are as follows:

* Mifare Classic page size: 16 byte
* NFC Forum Type 1 page size: 8 byte
* NFC Forum Type 2 page size: 4 byte
* NFC Forum Type 3 page size: 16 byte
* NFC Forum Type 4: No pages, page = file selection (CC or NDEF, see below)

The general approach for writing to a tag is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see :func:`Reader Get State` or
   :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Write Page` with page number and data
5. Wait for state to change to *ReaderWritePageReady* (see :func:`Reader Get State` or
   :cb:`Reader State Changed` callback)

If you use a Mifare Classic tag you have to authenticate a page before you
can write to it. See :func:`Reader Authenticate Mifare Classic Page`.

NFC Forum Type 4 tags are not organized into pages but different files. We currently
support two files: Capability Container file (CC) and NDEF file.

Choose CC by setting page to 3 or NDEF by setting page to 4.
"""
function reader_write_page_low_level(device::BrickletNFC, page, data_length, data_chunk_offset, data_chunk_data)
    device.deviceInternal.reader_write_page_low_level(page, data_length, data_chunk_offset, data_chunk_data)
end

export reader_request_page
"""
    $(SIGNATURES)

Reads a maximum of 8192 bytes starting from the given page and stores them into a buffer.
The buffer can then be read out with :func:`Reader Read Page`.
How many pages are read depends on the tag type. The page sizes are
as follows:

* Mifare Classic page size: 16 byte
* NFC Forum Type 1 page size: 8 byte
* NFC Forum Type 2 page size: 4 byte
* NFC Forum Type 3 page size: 16 byte
* NFC Forum Type 4: No pages, page = file selection (CC or NDEF, see below)

The general approach for reading a tag is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *RequestTagIDReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Request Page` with page number
5. Wait for state to change to *ReaderRequestPageReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
6. Call :func:`Reader Read Page` to retrieve the page from the buffer

If you use a Mifare Classic tag you have to authenticate a page before you
can read it. See :func:`Reader Authenticate Mifare Classic Page`.

NFC Forum Type 4 tags are not organized into pages but different files. We currently
support two files: Capability Container file (CC) and NDEF file.

Choose CC by setting page to 3 or NDEF by setting page to 4.
"""
function reader_request_page(device::BrickletNFC, page, length)
    device.deviceInternal.reader_request_page(page, length)
end

export reader_read_page_low_level
"""
    $(SIGNATURES)

Returns the page data from an internal buffer. To fill the buffer
with specific pages you have to call :func:`Reader Request Page` beforehand.
"""
function reader_read_page_low_level(device::BrickletNFC)
    return device.deviceInternal.reader_read_page_low_level()
end

export cardemu_get_state
"""
    $(SIGNATURES)

Returns the current cardemu state of the NFC Bricklet.

On startup the Bricklet will be in the *CardemuInitialization* state. The
initialization will only take about 20ms. After that it changes to *CardemuIdle*.

The Bricklet is also reinitialized if the mode is changed, see :func:`Set Mode`.

The functions of this Bricklet can be called in the *CardemuIdle* state and all of
the *CardemuReady* and *CardemuError* states.

Example: If you call :func:`Cardemu Start Discovery`, the state will change to
*CardemuDiscover* until the discovery is finished. Then it will change
to either *CardemuDiscoverReady* if it worked or to *CardemuDiscoverError* if it
didn't.

The same approach is used analogously for the other API functions.
"""
function cardemu_get_state(device::BrickletNFC)
    return device.deviceInternal.cardemu_get_state()
end

export cardemu_start_discovery
"""
    $(SIGNATURES)

Starts the discovery process. If you call this function while a NFC
reader device is near to the NFC Bricklet the state will change from
*CardemuDiscovery* to *CardemuDiscoveryReady*.

If no NFC reader device can be found or if there is an error during
discovery the cardemu state will change to *CardemuDiscoveryError*. In this case you
have to restart the discovery process.

If the cardemu state changes to *CardemuDiscoveryReady* you can start the NDEF message
transfer with :func:`Cardemu Write NDEF` and :func:`Cardemu Start Transfer`.
"""
function cardemu_start_discovery(device::BrickletNFC)
    device.deviceInternal.cardemu_start_discovery()
end

export cardemu_write_ndef_low_level
"""
    $(SIGNATURES)

Writes the NDEF message that is to be transferred to the NFC peer.

The maximum supported NDEF message size in Cardemu mode is 255 byte.

You can call this function at any time in Cardemu mode. The internal buffer
will not be overwritten until you call this function again or change the
mode.
"""
function cardemu_write_ndef_low_level(device::BrickletNFC, ndef_length, ndef_chunk_offset, ndef_chunk_data)
    device.deviceInternal.cardemu_write_ndef_low_level(ndef_length, ndef_chunk_offset, ndef_chunk_data)
end

export cardemu_start_transfer
"""
    $(SIGNATURES)

You can start the transfer of a NDEF message if the cardemu state is *CardemuDiscoveryReady*.

Before you call this function to start a write transfer, the NDEF message that
is to be transferred has to be written via :func:`Cardemu Write NDEF` first.

After you call this function the state will change to *CardemuTransferNDEF*. It will
change to *CardemuTransferNDEFReady* if the transfer was successful or
*CardemuTransferNDEFError* if it wasn't.
"""
function cardemu_start_transfer(device::BrickletNFC, transfer)
    device.deviceInternal.cardemu_start_transfer(transfer)
end

export p2p_get_state
"""
    $(SIGNATURES)

Returns the current P2P state of the NFC Bricklet.

On startup the Bricklet will be in the *P2PInitialization* state. The
initialization will only take about 20ms. After that it changes to *P2PIdle*.

The Bricklet is also reinitialized if the mode is changed, see :func:`Set Mode`.

The functions of this Bricklet can be called in the *P2PIdle* state and all of
the *P2PReady* and *P2PError* states.

Example: If you call :func:`P2P Start Discovery`, the state will change to
*P2PDiscover* until the discovery is finished. Then it will change
to either P2PDiscoverReady* if it worked or to *P2PDiscoverError* if it
didn't.

The same approach is used analogously for the other API functions.
"""
function p2p_get_state(device::BrickletNFC)
    return device.deviceInternal.p2p_get_state()
end

export p2p_start_discovery
"""
    $(SIGNATURES)

Starts the discovery process. If you call this function while another NFC
P2P enabled device is near to the NFC Bricklet the state will change from
*P2PDiscovery* to *P2PDiscoveryReady*.

If no NFC P2P enabled device can be found or if there is an error during
discovery the P2P state will change to *P2PDiscoveryError*. In this case you
have to restart the discovery process.

If the P2P state changes to *P2PDiscoveryReady* you can start the NDEF message
transfer with :func:`P2P Start Transfer`.
"""
function p2p_start_discovery(device::BrickletNFC)
    device.deviceInternal.p2p_start_discovery()
end

export p2p_write_ndef_low_level
"""
    $(SIGNATURES)

Writes the NDEF message that is to be transferred to the NFC peer.

The maximum supported NDEF message size for P2P transfer is 255 byte.

You can call this function at any time in P2P mode. The internal buffer
will not be overwritten until you call this function again, change the
mode or use P2P to read an NDEF messages.
"""
function p2p_write_ndef_low_level(device::BrickletNFC, ndef_length, ndef_chunk_offset, ndef_chunk_data)
    device.deviceInternal.p2p_write_ndef_low_level(ndef_length, ndef_chunk_offset, ndef_chunk_data)
end

export p2p_start_transfer
"""
    $(SIGNATURES)

You can start the transfer of a NDEF message if the P2P state is *P2PDiscoveryReady*.

Before you call this function to start a write transfer, the NDEF message that
is to be transferred has to be written via :func:`P2P Write NDEF` first.

After you call this function the P2P state will change to *P2PTransferNDEF*. It will
change to *P2PTransferNDEFReady* if the transfer was successfull or
*P2PTransferNDEFError* if it wasn't.

If you started a write transfer you are now done. If you started a read transfer
you can now use :func:`P2P Read NDEF` to read the NDEF message that was written
by the NFC peer.
"""
function p2p_start_transfer(device::BrickletNFC, transfer)
    device.deviceInternal.p2p_start_transfer(transfer)
end

export p2p_read_ndef_low_level
"""
    $(SIGNATURES)

Returns the NDEF message that was written by a NFC peer in NFC P2P mode.

The NDEF message is ready if you called :func:`P2P Start Transfer` with a
read transfer and the P2P state changed to *P2PTransferNDEFReady*.
"""
function p2p_read_ndef_low_level(device::BrickletNFC)
    return device.deviceInternal.p2p_read_ndef_low_level()
end

export set_detection_led_config
"""
    $(SIGNATURES)

Sets the detection LED configuration. By default the LED shows
if a card/reader is detected.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_detection_led_config(device::BrickletNFC, config)
    device.deviceInternal.set_detection_led_config(config)
end

export get_detection_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Detection LED Config`
"""
function get_detection_led_config(device::BrickletNFC)
    return device.deviceInternal.get_detection_led_config()
end

export set_maximum_timeout
"""
    $(SIGNATURES)

Sets the maximum timeout.

This is a global maximum used for all internal state timeouts. The timeouts depend heavily
on the used tags etc. For example: If you use a Type 2 tag and you want to detect if
it is present, you have to use :func:`Reader Request Tag ID` and wait for the state
to change to either the error state or the ready state.

With the default configuration this takes 2-3 seconds. By setting the maximum timeout to
100ms you can reduce this time to ~150-200ms. For Type 2 this would also still work
with a 20ms timeout (a Type 2 tag answers usually within 10ms). A type 4 tag can take
up to 500ms in our tests.

If you need a fast response time to discover if a tag is present or not you can find
a good timeout value by trial and error for your specific tag.

By default we use a very conservative timeout, to be sure that any tag can always
answer in time.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_maximum_timeout(device::BrickletNFC, timeout)
    device.deviceInternal.set_maximum_timeout(timeout)
end

export get_maximum_timeout
"""
    $(SIGNATURES)

Returns the timeout as set by :func:`Set Maximum Timeout`

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_maximum_timeout(device::BrickletNFC)
    return device.deviceInternal.get_maximum_timeout()
end

export simple_get_tag_id_low_level
"""
    $(SIGNATURES)

.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function simple_get_tag_id_low_level(device::BrickletNFC, index)
    return device.deviceInternal.simple_get_tag_id_low_level(index)
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

The errors counts are for errors that occur on the Bricklet side. All
Bricks have a similar function that returns the errors on the Brick side.
"""
function get_spitfp_error_count(device::BrickletNFC)
    return device.deviceInternal.get_spitfp_error_count()
end

export set_bootloader_mode
"""
    $(SIGNATURES)

Sets the bootloader mode and returns the status after the requested
mode change was instigated.

You can change from bootloader mode to firmware mode and vice versa. A change
from bootloader mode to firmware mode will only take place if the entry function,
device identifier and CRC are present and correct.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_bootloader_mode(device::BrickletNFC, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletNFC)
    return device.deviceInternal.get_bootloader_mode()
end

export set_write_firmware_pointer
"""
    $(SIGNATURES)

Sets the firmware pointer for :func:`Write Firmware`. The pointer has
to be increased by chunks of size 64. The data is written to flash
every 4 chunks (which equals to one page of size 256).

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_write_firmware_pointer(device::BrickletNFC, pointer)
    device.deviceInternal.set_write_firmware_pointer(pointer)
end

export write_firmware
"""
    $(SIGNATURES)

Writes 64 Bytes of firmware at the position as written by
:func:`Set Write Firmware Pointer` before. The firmware is written
to flash every 4 chunks.

You can only write firmware in bootloader mode.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_firmware(device::BrickletNFC, data)
    return device.deviceInternal.write_firmware(data)
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status LED configuration. By default the LED shows
communication traffic between Brick and Bricklet, it flickers once
for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is will show heartbeat by default.
"""
function set_status_led_config(device::BrickletNFC, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletNFC)
    return device.deviceInternal.get_status_led_config()
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has bad
accuracy. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickletNFC)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Bricklet. All configurations
will be lost.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickletNFC)
    device.deviceInternal.reset()
end

export write_uid
"""
    $(SIGNATURES)

Writes a new UID into flash. If you want to set a new UID
you have to decode the Base58 encoded UID string into an
integer first.

We recommend that you use Brick Viewer to change the UID.
"""
function write_uid(device::BrickletNFC, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletNFC)
    return device.deviceInternal.read_uid()
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Bricklet is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position can be 'a', 'b', 'c', 'd', 'e', 'f', 'g' or 'h' (Bricklet Port).
A Bricklet connected to an :ref:`Isolator Bricklet <isolator_bricklet>` is always at
position 'z'.

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickletNFC)
    return device.deviceInternal.get_identity()
end

export reader_get_tag_id
"""
Returns the tag type and the tag ID. This function can only be called if the
NFC Bricklet is currently in one of the *ReaderReady* states. The returned tag ID
is the tag ID that was saved through the last call of :func:`Reader Request Tag ID`.

To get the tag ID of a tag the approach is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see :func:`Reader Get State` or
   :cb:`Reader State Changed` callback)
3. Call :func:`Reader Get Tag ID`
"""
function reader_get_tag_id(device::BrickletNFC)

    ret = reader_get_tag_id_low_level(device, )

        return ReaderGetTagID(ret.tag_type, ret.tag_id_data[:ret.tag_id_length])
end

export reader_write_ndef
"""
Writes NDEF formated data.

This function currently supports NFC Forum Type 2 and 4.

The general approach for writing a NDEF message is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see
   :func:`Reader Get State` or :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check
   if the expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Write NDEF` with the NDEF message that you want to write
5. Wait for state to change to *ReaderWriteNDEFReady* (see :func:`Reader Get State`
   or :cb:`Reader State Changed` callback)
"""
function reader_write_ndef(device::BrickletNFC, ndef)

        ndef = convert(Vector{UInt8}, ndef)

    if length(ndef) > 65535
        throw(TinkerforgeInvalidParameterError("NDEF can be at most 65535 items long"))
    end

    ndef_length = length(ndef)
    ndef_chunk_offset = 0

    if ndef_length == 0
        ndef_chunk_data = [0] * 60
        ret = reader_write_ndef_low_level(device, ndef_length, ndef_chunk_offset, ndef_chunk_data)
    else
        lock(device.stream_lock) do
            while ndef_chunk_offset < ndef_length
                ndef_chunk_data = create_chunk_data(ndef, ndef_chunk_offset, 60, 0)
                ret = reader_write_ndef_low_level(device, ndef_length, ndef_chunk_offset, ndef_chunk_data)
                ndef_chunk_offset += 60
            end
        end
    end

        return ret
end

export reader_read_ndef
"""
Returns the NDEF data from an internal buffer. To fill the buffer
with a NDEF message you have to call :func:`Reader Request NDEF` beforehand.
"""
function reader_read_ndef(device::BrickletNFC)

    lock(device.stream_lock) do
        ret = reader_read_ndef_low_level(device, )
            ndef_length = ret.ndef_length
        ndef_out_of_sync = ret.ndef_chunk_offset != 0

        ndef_data = ret.ndef_chunk_data

        while !ndef_out_of_sync && length(ndef_data) < ndef_length
            ret = reader_read_ndef_low_level(device, )
                ndef_length = ret.ndef_length
            ndef_out_of_sync = ret.ndef_chunk_offset != length(ndef_data)
            ndef_data += ret.ndef_chunk_data
        end

        if ndef_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.ndef_chunk_offset + 60 < ndef_length
                ret = reader_read_ndef_low_level(device, )
                    ndef_length = ret.ndef_length
            end

            throw(TinkerforgeStreamOutOfSyncError("NDEF stream is out-of-sync"))
        end
    end

        return ndef_data[:ndef_length]
end

export reader_write_page
"""
Writes a maximum of 8192 bytes starting from the given page. How many pages are written
depends on the tag type. The page sizes are as follows:

* Mifare Classic page size: 16 byte
* NFC Forum Type 1 page size: 8 byte
* NFC Forum Type 2 page size: 4 byte
* NFC Forum Type 3 page size: 16 byte
* NFC Forum Type 4: No pages, page = file selection (CC or NDEF, see below)

The general approach for writing to a tag is as follows:

1. Call :func:`Reader Request Tag ID`
2. Wait for state to change to *ReaderRequestTagIDReady* (see :func:`Reader Get State` or
   :cb:`Reader State Changed` callback)
3. If looking for a specific tag then call :func:`Reader Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Reader Write Page` with page number and data
5. Wait for state to change to *ReaderWritePageReady* (see :func:`Reader Get State` or
   :cb:`Reader State Changed` callback)

If you use a Mifare Classic tag you have to authenticate a page before you
can write to it. See :func:`Reader Authenticate Mifare Classic Page`.

NFC Forum Type 4 tags are not organized into pages but different files. We currently
support two files: Capability Container file (CC) and NDEF file.

Choose CC by setting page to 3 or NDEF by setting page to 4.
"""
function reader_write_page(device::BrickletNFC, page, data)

        page = UInt16(page)
    data = convert(Vector{UInt8}, data)

    if length(data) > 65535
        throw(TinkerforgeInvalidParameterError("Data can be at most 65535 items long"))
    end

    data_length = length(data)
    data_chunk_offset = 0

    if data_length == 0
        data_chunk_data = [0] * 58
        ret = reader_write_page_low_level(device, page, data_length, data_chunk_offset, data_chunk_data)
    else
        lock(device.stream_lock) do
            while data_chunk_offset < data_length
                data_chunk_data = create_chunk_data(data, data_chunk_offset, 58, 0)
                ret = reader_write_page_low_level(device, page, data_length, data_chunk_offset, data_chunk_data)
                data_chunk_offset += 58
            end
        end
    end

        return ret
end

export reader_read_page
"""
Returns the page data from an internal buffer. To fill the buffer
with specific pages you have to call :func:`Reader Request Page` beforehand.
"""
function reader_read_page(device::BrickletNFC)

    lock(device.stream_lock) do
        ret = reader_read_page_low_level(device, )
            data_length = ret.data_length
        data_out_of_sync = ret.data_chunk_offset != 0

        data_data = ret.data_chunk_data

        while !data_out_of_sync && length(data_data) < data_length
            ret = reader_read_page_low_level(device, )
                data_length = ret.data_length
            data_out_of_sync = ret.data_chunk_offset != length(data_data)
            data_data += ret.data_chunk_data
        end

        if data_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.data_chunk_offset + 60 < data_length
                ret = reader_read_page_low_level(device, )
                    data_length = ret.data_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Data stream is out-of-sync"))
        end
    end

        return data_data[:data_length]
end

export cardemu_write_ndef
"""
Writes the NDEF message that is to be transferred to the NFC peer.

The maximum supported NDEF message size in Cardemu mode is 255 byte.

You can call this function at any time in Cardemu mode. The internal buffer
will not be overwritten until you call this function again or change the
mode.
"""
function cardemu_write_ndef(device::BrickletNFC, ndef)

        ndef = convert(Vector{UInt8}, ndef)

    if length(ndef) > 65535
        throw(TinkerforgeInvalidParameterError("NDEF can be at most 65535 items long"))
    end

    ndef_length = length(ndef)
    ndef_chunk_offset = 0

    if ndef_length == 0
        ndef_chunk_data = [0] * 60
        ret = cardemu_write_ndef_low_level(device, ndef_length, ndef_chunk_offset, ndef_chunk_data)
    else
        lock(device.stream_lock) do
            while ndef_chunk_offset < ndef_length
                ndef_chunk_data = create_chunk_data(ndef, ndef_chunk_offset, 60, 0)
                ret = cardemu_write_ndef_low_level(device, ndef_length, ndef_chunk_offset, ndef_chunk_data)
                ndef_chunk_offset += 60
            end
        end
    end

        return ret
end

export p2p_write_ndef
"""
Writes the NDEF message that is to be transferred to the NFC peer.

The maximum supported NDEF message size for P2P transfer is 255 byte.

You can call this function at any time in P2P mode. The internal buffer
will not be overwritten until you call this function again, change the
mode or use P2P to read an NDEF messages.
"""
function p2p_write_ndef(device::BrickletNFC, ndef)

        ndef = convert(Vector{UInt8}, ndef)

    if length(ndef) > 65535
        throw(TinkerforgeInvalidParameterError("NDEF can be at most 65535 items long"))
    end

    ndef_length = length(ndef)
    ndef_chunk_offset = 0

    if ndef_length == 0
        ndef_chunk_data = [0] * 60
        ret = p2p_write_ndef_low_level(device, ndef_length, ndef_chunk_offset, ndef_chunk_data)
    else
        lock(device.stream_lock) do
            while ndef_chunk_offset < ndef_length
                ndef_chunk_data = create_chunk_data(ndef, ndef_chunk_offset, 60, 0)
                ret = p2p_write_ndef_low_level(device, ndef_length, ndef_chunk_offset, ndef_chunk_data)
                ndef_chunk_offset += 60
            end
        end
    end

        return ret
end

export p2p_read_ndef
"""
Returns the NDEF message that was written by a NFC peer in NFC P2P mode.

The NDEF message is ready if you called :func:`P2P Start Transfer` with a
read transfer and the P2P state changed to *P2PTransferNDEFReady*.
"""
function p2p_read_ndef(device::BrickletNFC)

    lock(device.stream_lock) do
        ret = p2p_read_ndef_low_level(device, )
            ndef_length = ret.ndef_length
        ndef_out_of_sync = ret.ndef_chunk_offset != 0

        ndef_data = ret.ndef_chunk_data

        while !ndef_out_of_sync && length(ndef_data) < ndef_length
            ret = p2p_read_ndef_low_level(device, )
                ndef_length = ret.ndef_length
            ndef_out_of_sync = ret.ndef_chunk_offset != length(ndef_data)
            ndef_data += ret.ndef_chunk_data
        end

        if ndef_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.ndef_chunk_offset + 60 < ndef_length
                ret = p2p_read_ndef_low_level(device, )
                    ndef_length = ret.ndef_length
            end

            throw(TinkerforgeStreamOutOfSyncError("NDEF stream is out-of-sync"))
        end
    end

        return ndef_data[:ndef_length]
end

export simple_get_tag_id
"""
.. versionadded:: 2.0.6\$nbsp;(Plugin)
"""
function simple_get_tag_id(device::BrickletNFC, index)

        index = UInt8(index)

    ret = simple_get_tag_id_low_level(device, index)

        return SimpleGetTagID(ret.tag_type, ret.tag_id_data[:ret.tag_id_length], ret.last_seen)
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletNFC, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
