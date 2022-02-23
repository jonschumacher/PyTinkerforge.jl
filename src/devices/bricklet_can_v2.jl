


export BrickletCANV2ReadFrameLowLevel
struct BrickletCANV2ReadFrameLowLevel
    success::Bool
    frame_type::Integer
    identifier::Integer
    data_length::Integer
    data_data::Vector{Integer}
end

export BrickletCANV2TransceiverConfiguration
struct BrickletCANV2TransceiverConfiguration
    baud_rate::Integer
    sample_point::Integer
    transceiver_mode::Integer
end

export BrickletCANV2QueueConfigurationLowLevel
struct BrickletCANV2QueueConfigurationLowLevel
    write_buffer_size::Integer
    write_buffer_timeout::Integer
    write_backlog_size::Integer
    read_buffer_sizes_length::Integer
    read_buffer_sizes_data::Vector{Integer}
    read_backlog_size::Integer
end

export BrickletCANV2ReadFilterConfiguration
struct BrickletCANV2ReadFilterConfiguration
    filter_mode::Integer
    filter_mask::Integer
    filter_identifier::Integer
end

export BrickletCANV2ErrorLogLowLevel
struct BrickletCANV2ErrorLogLowLevel
    transceiver_state::Integer
    transceiver_write_error_level::Integer
    transceiver_read_error_level::Integer
    transceiver_stuffing_error_count::Integer
    transceiver_format_error_count::Integer
    transceiver_ack_error_count::Integer
    transceiver_bit1_error_count::Integer
    transceiver_bit0_error_count::Integer
    transceiver_crc_error_count::Integer
    write_buffer_timeout_error_count::Integer
    read_buffer_overflow_error_count::Integer
    read_buffer_overflow_error_occurred_length::Integer
    read_buffer_overflow_error_occurred_data::Vector{Bool}
    read_backlog_overflow_error_count::Integer
end

export BrickletCANV2SPITFPErrorCount
struct BrickletCANV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletCANV2Identity
struct BrickletCANV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletCANV2ReadFrame
struct BrickletCANV2ReadFrame
    success::Bool
    frame_type::Integer
    identifier::Integer
    data::Vector{Integer}
end

export BrickletCANV2QueueConfiguration
struct BrickletCANV2QueueConfiguration
    write_buffer_size::Integer
    write_buffer_timeout::Integer
    write_backlog_size::Integer
    read_buffer_sizes::Vector{Integer}
    read_backlog_size::Integer
end

export BrickletCANV2ErrorLog
struct BrickletCANV2ErrorLog
    transceiver_state::Integer
    transceiver_write_error_level::Integer
    transceiver_read_error_level::Integer
    transceiver_stuffing_error_count::Integer
    transceiver_format_error_count::Integer
    transceiver_ack_error_count::Integer
    transceiver_bit1_error_count::Integer
    transceiver_bit0_error_count::Integer
    transceiver_crc_error_count::Integer
    write_buffer_timeout_error_count::Integer
    read_buffer_overflow_error_count::Integer
    read_buffer_overflow_error_occurred::Vector{Bool}
    read_backlog_overflow_error_count::Integer
end

export BrickletCANV2
"""
Communicates with CAN bus devices
"""
mutable struct BrickletCANV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletCANV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_can_v2")
        deviceInternal = package.BrickletCANV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_frame_low_level
"""
    $(SIGNATURES)

Writes a data or remote frame to the write queue to be transmitted over the
CAN transceiver.

The Bricklet supports the standard 11-bit (CAN 2.0A) and the additional extended
29-bit (CAN 2.0B) identifiers. For standard frames the Bricklet uses bit 0 to 10
from the ``identifier`` parameter as standard 11-bit identifier. For extended
frames the Bricklet uses bit 0 to 28 from the ``identifier`` parameter as
extended 29-bit identifier.

The ``data`` parameter can be up to 15 bytes long. For data frames up to 8 bytes
will be used as the actual data. The length (DLC) field in the data or remote
frame will be set to the actual length of the ``data`` parameter. This allows
to transmit data and remote frames with excess length. For remote frames only
the length of the ``data`` parameter is used. The actual ``data`` bytes are
ignored.

Returns *true* if the frame was successfully added to the write queue. Returns
*false* if the frame could not be added because write queue is already full or
because the write buffer or the write backlog are configured with a size of
zero (see :func:`Set Queue Configuration`).

The write queue can overflow if frames are written to it at a higher rate
than the Bricklet can transmitted them over the CAN transceiver. This may
happen if the CAN transceiver is configured as read-only or is using a low baud
rate (see :func:`Set Transceiver Configuration`). It can also happen if the CAN
bus is congested and the frame cannot be transmitted because it constantly loses
arbitration or because the CAN transceiver is currently disabled due to a high
write error level (see :func:`Get Error Log`).
"""
function write_frame_low_level(device::BrickletCANV2, frame_type, identifier, data_length, data_data)
    return device.deviceInternal.write_frame_low_level(frame_type, identifier, data_length, data_data)
end

export read_frame_low_level
"""
    $(SIGNATURES)

Tries to read the next data or remote frame from the read queue and returns it.
If a frame was successfully read, then the ``success`` return value is set to
*true* and the other return values contain the frame. If the read queue is
empty and no frame could be read, then the ``success`` return value is set to
*false* and the other return values contain invalid data.

The ``identifier`` return value follows the identifier format described for
:func:`Write Frame`.

The ``data`` return value can be up to 15 bytes long. For data frames up to the
first 8 bytes are the actual received data. All bytes after the 8th byte are
always zero and only there to indicate the length of a data or remote frame
with excess length. For remote frames the length of the ``data`` return value
represents the requested length. The actual ``data`` bytes are always zero.

A configurable read filter can be used to define which frames should be
received by the CAN transceiver and put into the read queue (see
:func:`Set Read Filter Configuration`).

Instead of polling with this function, you can also use callbacks. See the
:func:`Set Frame Read Callback Configuration` function and the :cb:`Frame Read`
callback.
"""
function read_frame_low_level(device::BrickletCANV2)
    return device.deviceInternal.read_frame_low_level()
end

export set_frame_read_callback_configuration
"""
    $(SIGNATURES)

Enables and disables the :cb:`Frame Read` callback.

By default the callback is disabled. Enabling this callback will disable the :cb:`Frame Readable` callback.
"""
function set_frame_read_callback_configuration(device::BrickletCANV2, enabled)
    device.deviceInternal.set_frame_read_callback_configuration(enabled)
end

export get_frame_read_callback_configuration
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Frame Read` callback is enabled, *false* otherwise.
"""
function get_frame_read_callback_configuration(device::BrickletCANV2)
    return device.deviceInternal.get_frame_read_callback_configuration()
end

export set_transceiver_configuration
"""
    $(SIGNATURES)

Sets the transceiver configuration for the CAN bus communication.

The CAN transceiver has three different modes:

* Normal: Reads from and writes to the CAN bus and performs active bus
  error detection and acknowledgement.
* Loopback: All reads and writes are performed internally. The transceiver
  is disconnected from the actual CAN bus.
* Read-Only: Only reads from the CAN bus, but does neither active bus error
  detection nor acknowledgement. Only the receiving part of the transceiver
  is connected to the CAN bus.
"""
function set_transceiver_configuration(device::BrickletCANV2, baud_rate, sample_point, transceiver_mode)
    device.deviceInternal.set_transceiver_configuration(baud_rate, sample_point, transceiver_mode)
end

export get_transceiver_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Transceiver Configuration`.
"""
function get_transceiver_configuration(device::BrickletCANV2)
    return device.deviceInternal.get_transceiver_configuration()
end

export set_queue_configuration_low_level
"""
    $(SIGNATURES)

Sets the write and read queue configuration.

The CAN transceiver has 32 buffers in total in hardware for transmitting and
receiving frames. Additionally, the Bricklet has a backlog for 768 frames in
total in software. The buffers and the backlog can be freely assigned to the
write and read queues.

:func:`Write Frame` writes a frame into the write backlog. The Bricklet moves
the frame from the backlog into a free write buffer. The CAN transceiver then
transmits the frame from the write buffer to the CAN bus. If there are no
write buffers (``write_buffer_size`` is zero) or there is no write backlog
(``write_backlog_size`` is zero) then no frames can be transmitted and
:func:`Write Frame` returns always *false*.

The CAN transceiver receives a frame from the CAN bus and stores it into a
free read buffer. The Bricklet moves the frame from the read buffer into the
read backlog. :func:`Read Frame` reads the frame from the read backlog and
returns it. If there are no read buffers (``read_buffer_sizes`` is empty) or
there is no read backlog (``read_backlog_size`` is zero) then no frames can be
received and :func:`Read Frame` returns always *false*.

There can be multiple read buffers, because the CAN transceiver cannot receive
data and remote frames into the same read buffer. A positive read buffer size
represents a data frame read buffer and a negative read buffer size represents
a remote frame read buffer. A read buffer size of zero is not allowed. By
default the first read buffer is configured for data frames and the second read
buffer is configured for remote frame. There can be up to 32 different read
buffers, assuming that no write buffer is used. Each read buffer has its own
filter configuration (see :func:`Set Read Filter Configuration`).

A valid queue configuration fulfills these conditions::

 write_buffer_size + abs(read_buffer_size_0) + abs(read_buffer_size_1) + ... + abs(read_buffer_size_31) <= 32
 write_backlog_size + read_backlog_size <= 768

The write buffer timeout has three different modes that define how a failed
frame transmission should be handled:

* Single-Shot (< 0): Only one transmission attempt will be made. If the
  transmission fails then the frame is discarded.
* Infinite (= 0): Infinite transmission attempts will be made. The frame will
  never be discarded.
* Milliseconds (> 0): A limited number of transmission attempts will be made.
  If the frame could not be transmitted successfully after the configured
  number of milliseconds then the frame is discarded.

The current content of the queues is lost when this function is called.
"""
function set_queue_configuration_low_level(device::BrickletCANV2, write_buffer_size, write_buffer_timeout, write_backlog_size, read_buffer_sizes_length, read_buffer_sizes_data, read_backlog_size)
    device.deviceInternal.set_queue_configuration_low_level(write_buffer_size, write_buffer_timeout, write_backlog_size, read_buffer_sizes_length, read_buffer_sizes_data, read_backlog_size)
end

export get_queue_configuration_low_level
"""
    $(SIGNATURES)

Returns the queue configuration as set by :func:`Set Queue Configuration`.
"""
function get_queue_configuration_low_level(device::BrickletCANV2)
    return device.deviceInternal.get_queue_configuration_low_level()
end

export set_read_filter_configuration
"""
    $(SIGNATURES)

Set the read filter configuration for the given read buffer index. This can be
used to define which frames should be received by the CAN transceiver and put
into the read buffer.

The read filter has four different modes that define if and how the filter mask
and the filter identifier are applied:

* Accept-All: All frames are received.
* Match-Standard-Only: Only standard frames with a matching identifier are
  received.
* Match-Extended-Only: Only extended frames with a matching identifier are
  received.
* Match-Standard-And-Extended: Standard and extended frames with a matching
  identifier are received.

The filter mask and filter identifier are used as bit masks. Their usage
depends on the mode:

* Accept-All: Mask and identifier are ignored.
* Match-Standard-Only: Bit 0 to 10 (11 bits) of filter mask and filter
  identifier are used to match the 11-bit identifier of standard frames.
* Match-Extended-Only: Bit 0 to 28 (29 bits) of filter mask and filter
  identifier are used to match the 29-bit identifier of extended frames.
* Match-Standard-And-Extended: Bit 18 to 28 (11 bits) of filter mask and filter
  identifier are used to match the 11-bit identifier of standard frames, bit 0
  to 17 (18 bits) are ignored in this case. Bit 0 to 28 (29 bits) of filter
  mask and filter identifier are used to match the 29-bit identifier of extended
  frames.

The filter mask and filter identifier are applied in this way: The filter mask
is used to select the frame identifier bits that should be compared to the
corresponding filter identifier bits. All unselected bits are automatically
accepted. All selected bits have to match the filter identifier to be accepted.
If all bits for the selected mode are accepted then the frame is accepted and
is added to the read buffer.

.. csv-table::
 :header: "Filter Mask Bit", "Filter Identifier Bit", "Frame Identifier Bit", "Result"
 :widths: 10, 10, 10, 10

 0, X, X, Accept
 1, 0, 0, Accept
 1, 0, 1, Reject
 1, 1, 0, Reject
 1, 1, 1, Accept

For example, to receive standard frames with identifier 0x123 only, the mode
can be set to Match-Standard-Only with 0x7FF as mask and 0x123 as identifier.
The mask of 0x7FF selects all 11 identifier bits for matching so that the
identifier has to be exactly 0x123 to be accepted.

To accept identifier 0x123 and identifier 0x456 at the same time, just set
filter 2 to 0x456 and keep mask and filter 1 unchanged.

There can be up to 32 different read filters configured at the same time,
because there can be up to 32 read buffer (see :func:`Set Queue Configuration`).

The default mode is accept-all for all read buffers.
"""
function set_read_filter_configuration(device::BrickletCANV2, buffer_index, filter_mode, filter_mask, filter_identifier)
    device.deviceInternal.set_read_filter_configuration(buffer_index, filter_mode, filter_mask, filter_identifier)
end

export get_read_filter_configuration
"""
    $(SIGNATURES)

Returns the read filter configuration as set by :func:`Set Read Filter Configuration`.
"""
function get_read_filter_configuration(device::BrickletCANV2, buffer_index)
    return device.deviceInternal.get_read_filter_configuration(buffer_index)
end

export get_error_log_low_level
"""
    $(SIGNATURES)

Returns information about different kinds of errors.

The write and read error levels indicate the current level of stuffing, form,
acknowledgement, bit and checksum errors during CAN bus write and read
operations. For each of this error kinds there is also an individual counter.

When the write error level extends 255 then the CAN transceiver gets disabled
and no frames can be transmitted or received anymore. The CAN transceiver will
automatically be activated again after the CAN bus is idle for a while.

The write buffer timeout, read buffer and backlog overflow counts represents the
number of these errors:

* A write buffer timeout occurs if a frame could not be transmitted before the
  configured write buffer timeout expired (see :func:`Set Queue Configuration`).
* A read buffer overflow occurs if a read buffer of the CAN transceiver
  still contains the last received frame when the next frame arrives. In this
  case the last received frame is lost. This happens if the CAN transceiver
  receives more frames than the Bricklet can handle. Using the read filter
  (see :func:`Set Read Filter Configuration`) can help to reduce the amount of
  received frames. This count is not exact, but a lower bound, because the
  Bricklet might not able detect all overflows if they occur in rapid succession.
* A read backlog overflow occurs if the read backlog of the Bricklet is already
  full when the next frame should be read from a read buffer of the CAN
  transceiver. In this case the frame in the read buffer is lost. This
  happens if the CAN transceiver receives more frames to be added to the read
  backlog than are removed from the read backlog using the :func:`Read Frame`
  function. Using the :cb:`Frame Read` callback ensures that the read backlog
  can not overflow.

The read buffer overflow counter counts the overflows of all configured read
buffers. Which read buffer exactly suffered from an overflow can be figured
out from the read buffer overflow occurrence list
(``read_buffer_overflow_error_occurred``). Reading the error log clears the
occurence list.
"""
function get_error_log_low_level(device::BrickletCANV2)
    return device.deviceInternal.get_error_log_low_level()
end

export set_communication_led_config
"""
    $(SIGNATURES)

Sets the communication LED configuration. By default the LED shows
CAN-Bus traffic, it flickers once for every 40 transmitted or received frames.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_communication_led_config(device::BrickletCANV2, config)
    device.deviceInternal.set_communication_led_config(config)
end

export get_communication_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Communication LED Config`
"""
function get_communication_led_config(device::BrickletCANV2)
    return device.deviceInternal.get_communication_led_config()
end

export set_error_led_config
"""
    $(SIGNATURES)

Sets the error LED configuration.

By default (show-transceiver-state) the error LED turns on if the CAN
transceiver is passive or disabled state (see :func:`Get Error Log`). If
the CAN transceiver is in active state the LED turns off.

If the LED is configured as show-error then the error LED turns on if any error
occurs. If you call this function with the show-error option again, the LED will
turn off until the next error occurs.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_error_led_config(device::BrickletCANV2, config)
    device.deviceInternal.set_error_led_config(config)
end

export get_error_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Error LED Config`.
"""
function get_error_led_config(device::BrickletCANV2)
    return device.deviceInternal.get_error_led_config()
end

export set_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Enables and disables the :cb:`Frame Readable` callback.

By default the callback is disabled. Enabling this callback will disable the :cb:`Frame Read` callback.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_frame_readable_callback_configuration(device::BrickletCANV2, enabled)
    device.deviceInternal.set_frame_readable_callback_configuration(enabled)
end

export get_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Frame Readable` callback is enabled, *false* otherwise.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_frame_readable_callback_configuration(device::BrickletCANV2)
    return device.deviceInternal.get_frame_readable_callback_configuration()
end

export set_error_occurred_callback_configuration
"""
    $(SIGNATURES)

Enables and disables the :cb:`Error Occurred` callback.

By default the callback is disabled.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_error_occurred_callback_configuration(device::BrickletCANV2, enabled)
    device.deviceInternal.set_error_occurred_callback_configuration(enabled)
end

export get_error_occurred_callback_configuration
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Error Occurred` callback is enabled, *false* otherwise.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_error_occurred_callback_configuration(device::BrickletCANV2)
    return device.deviceInternal.get_error_occurred_callback_configuration()
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
function get_spitfp_error_count(device::BrickletCANV2)
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
function set_bootloader_mode(device::BrickletCANV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletCANV2)
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
function set_write_firmware_pointer(device::BrickletCANV2, pointer)
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
function write_firmware(device::BrickletCANV2, data)
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
function set_status_led_config(device::BrickletCANV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletCANV2)
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
function get_chip_temperature(device::BrickletCANV2)
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
function reset(device::BrickletCANV2)
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
function write_uid(device::BrickletCANV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletCANV2)
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
function get_identity(device::BrickletCANV2)
    return device.deviceInternal.get_identity()
end

export write_frame
"""
Writes a data or remote frame to the write queue to be transmitted over the
CAN transceiver.

The Bricklet supports the standard 11-bit (CAN 2.0A) and the additional extended
29-bit (CAN 2.0B) identifiers. For standard frames the Bricklet uses bit 0 to 10
from the ``identifier`` parameter as standard 11-bit identifier. For extended
frames the Bricklet uses bit 0 to 28 from the ``identifier`` parameter as
extended 29-bit identifier.

The ``data`` parameter can be up to 15 bytes long. For data frames up to 8 bytes
will be used as the actual data. The length (DLC) field in the data or remote
frame will be set to the actual length of the ``data`` parameter. This allows
to transmit data and remote frames with excess length. For remote frames only
the length of the ``data`` parameter is used. The actual ``data`` bytes are
ignored.

Returns *true* if the frame was successfully added to the write queue. Returns
*false* if the frame could not be added because write queue is already full or
because the write buffer or the write backlog are configured with a size of
zero (see :func:`Set Queue Configuration`).

The write queue can overflow if frames are written to it at a higher rate
than the Bricklet can transmitted them over the CAN transceiver. This may
happen if the CAN transceiver is configured as read-only or is using a low baud
rate (see :func:`Set Transceiver Configuration`). It can also happen if the CAN
bus is congested and the frame cannot be transmitted because it constantly loses
arbitration or because the CAN transceiver is currently disabled due to a high
write error level (see :func:`Get Error Log`).
"""
function write_frame(device::BrickletCANV2, frame_type, identifier, data)

        frame_type = UInt8(frame_type)
    identifier = UInt32(identifier)
    data = convert(Vector{UInt8}, data)

    data_length = length(data)
    data_data = list(data) # make a copy so we can potentially extend it

    if data_length > 15
        throw(TinkerforgeInvalidParameterError("Data can be at most 15 items long"))
    end

    if data_length < 15
        data_data += [0] * (15 - data_length)
    end

        return write_frame_low_level(device, frame_type, identifier, data_length, data_data)
end

export read_frame
"""
Tries to read the next data or remote frame from the read queue and returns it.
If a frame was successfully read, then the ``success`` return value is set to
*true* and the other return values contain the frame. If the read queue is
empty and no frame could be read, then the ``success`` return value is set to
*false* and the other return values contain invalid data.

The ``identifier`` return value follows the identifier format described for
:func:`Write Frame`.

The ``data`` return value can be up to 15 bytes long. For data frames up to the
first 8 bytes are the actual received data. All bytes after the 8th byte are
always zero and only there to indicate the length of a data or remote frame
with excess length. For remote frames the length of the ``data`` return value
represents the requested length. The actual ``data`` bytes are always zero.

A configurable read filter can be used to define which frames should be
received by the CAN transceiver and put into the read queue (see
:func:`Set Read Filter Configuration`).

Instead of polling with this function, you can also use callbacks. See the
:func:`Set Frame Read Callback Configuration` function and the :cb:`Frame Read`
callback.
"""
function read_frame(device::BrickletCANV2)

    ret = read_frame_low_level(device, )

        return ReadFrame(ret.success, ret.frame_type, ret.identifier, ret.data_data[:ret.data_length])
end

export set_queue_configuration
"""
Sets the write and read queue configuration.

The CAN transceiver has 32 buffers in total in hardware for transmitting and
receiving frames. Additionally, the Bricklet has a backlog for 768 frames in
total in software. The buffers and the backlog can be freely assigned to the
write and read queues.

:func:`Write Frame` writes a frame into the write backlog. The Bricklet moves
the frame from the backlog into a free write buffer. The CAN transceiver then
transmits the frame from the write buffer to the CAN bus. If there are no
write buffers (``write_buffer_size`` is zero) or there is no write backlog
(``write_backlog_size`` is zero) then no frames can be transmitted and
:func:`Write Frame` returns always *false*.

The CAN transceiver receives a frame from the CAN bus and stores it into a
free read buffer. The Bricklet moves the frame from the read buffer into the
read backlog. :func:`Read Frame` reads the frame from the read backlog and
returns it. If there are no read buffers (``read_buffer_sizes`` is empty) or
there is no read backlog (``read_backlog_size`` is zero) then no frames can be
received and :func:`Read Frame` returns always *false*.

There can be multiple read buffers, because the CAN transceiver cannot receive
data and remote frames into the same read buffer. A positive read buffer size
represents a data frame read buffer and a negative read buffer size represents
a remote frame read buffer. A read buffer size of zero is not allowed. By
default the first read buffer is configured for data frames and the second read
buffer is configured for remote frame. There can be up to 32 different read
buffers, assuming that no write buffer is used. Each read buffer has its own
filter configuration (see :func:`Set Read Filter Configuration`).

A valid queue configuration fulfills these conditions::

 write_buffer_size + abs(read_buffer_size_0) + abs(read_buffer_size_1) + ... + abs(read_buffer_size_31) <= 32
 write_backlog_size + read_backlog_size <= 768

The write buffer timeout has three different modes that define how a failed
frame transmission should be handled:

* Single-Shot (< 0): Only one transmission attempt will be made. If the
  transmission fails then the frame is discarded.
* Infinite (= 0): Infinite transmission attempts will be made. The frame will
  never be discarded.
* Milliseconds (> 0): A limited number of transmission attempts will be made.
  If the frame could not be transmitted successfully after the configured
  number of milliseconds then the frame is discarded.

The current content of the queues is lost when this function is called.
"""
function set_queue_configuration(device::BrickletCANV2, write_buffer_size, write_buffer_timeout, write_backlog_size, read_buffer_sizes, read_backlog_size)

        write_buffer_size = UInt8(write_buffer_size)
    write_buffer_timeout = Int32(write_buffer_timeout)
    write_backlog_size = UInt16(write_backlog_size)
    read_buffer_sizes = convert(Vector{Int8}, read_buffer_sizes)
    read_backlog_size = UInt16(read_backlog_size)

    read_buffer_sizes_length = length(read_buffer_sizes)
    read_buffer_sizes_data = list(read_buffer_sizes) # make a copy so we can potentially extend it

    if read_buffer_sizes_length > 32
        throw(TinkerforgeInvalidParameterError("Read Buffer Sizes can be at most 32 items long"))
    end

    if read_buffer_sizes_length < 32
        read_buffer_sizes_data += [0] * (32 - read_buffer_sizes_length)
    end

        return set_queue_configuration_low_level(device, write_buffer_size, write_buffer_timeout, write_backlog_size, read_buffer_sizes_length, read_buffer_sizes_data, read_backlog_size)
end

export get_queue_configuration
"""
Returns the queue configuration as set by :func:`Set Queue Configuration`.
"""
function get_queue_configuration(device::BrickletCANV2)

    ret = get_queue_configuration_low_level(device, )

        return GetQueueConfiguration(ret.write_buffer_size, ret.write_buffer_timeout, ret.write_backlog_size, ret.read_buffer_sizes_data[:ret.read_buffer_sizes_length], ret.read_backlog_size)
end

export get_error_log
"""
Returns information about different kinds of errors.

The write and read error levels indicate the current level of stuffing, form,
acknowledgement, bit and checksum errors during CAN bus write and read
operations. For each of this error kinds there is also an individual counter.

When the write error level extends 255 then the CAN transceiver gets disabled
and no frames can be transmitted or received anymore. The CAN transceiver will
automatically be activated again after the CAN bus is idle for a while.

The write buffer timeout, read buffer and backlog overflow counts represents the
number of these errors:

* A write buffer timeout occurs if a frame could not be transmitted before the
  configured write buffer timeout expired (see :func:`Set Queue Configuration`).
* A read buffer overflow occurs if a read buffer of the CAN transceiver
  still contains the last received frame when the next frame arrives. In this
  case the last received frame is lost. This happens if the CAN transceiver
  receives more frames than the Bricklet can handle. Using the read filter
  (see :func:`Set Read Filter Configuration`) can help to reduce the amount of
  received frames. This count is not exact, but a lower bound, because the
  Bricklet might not able detect all overflows if they occur in rapid succession.
* A read backlog overflow occurs if the read backlog of the Bricklet is already
  full when the next frame should be read from a read buffer of the CAN
  transceiver. In this case the frame in the read buffer is lost. This
  happens if the CAN transceiver receives more frames to be added to the read
  backlog than are removed from the read backlog using the :func:`Read Frame`
  function. Using the :cb:`Frame Read` callback ensures that the read backlog
  can not overflow.

The read buffer overflow counter counts the overflows of all configured read
buffers. Which read buffer exactly suffered from an overflow can be figured
out from the read buffer overflow occurrence list
(``read_buffer_overflow_error_occurred``). Reading the error log clears the
occurence list.
"""
function get_error_log(device::BrickletCANV2)

    ret = get_error_log_low_level(device, )

        return GetErrorLog(ret.transceiver_state, ret.transceiver_write_error_level, ret.transceiver_read_error_level, ret.transceiver_stuffing_error_count, ret.transceiver_format_error_count, ret.transceiver_ack_error_count, ret.transceiver_bit1_error_count, ret.transceiver_bit0_error_count, ret.transceiver_crc_error_count, ret.write_buffer_timeout_error_count, ret.read_buffer_overflow_error_count, ret.read_buffer_overflow_error_occurred_data[:ret.read_buffer_overflow_error_occurred_length], ret.read_backlog_overflow_error_count)
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletCANV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
