


export BrickletCANReadFrame
struct BrickletCANReadFrame
    success::Bool
    frame_type::Integer
    identifier::Integer
    data::Vector{Integer}
    length::Integer
end

export BrickletCANConfiguration
struct BrickletCANConfiguration
    baud_rate::Integer
    transceiver_mode::Integer
    write_timeout::Integer
end

export BrickletCANReadFilter
struct BrickletCANReadFilter
    mode::Integer
    mask::Integer
    filter1::Integer
    filter2::Integer
end

export BrickletCANErrorLog
struct BrickletCANErrorLog
    write_error_level::Integer
    read_error_level::Integer
    transceiver_disabled::Bool
    write_timeout_count::Integer
    read_register_overflow_count::Integer
    read_buffer_overflow_count::Integer
end

export BrickletCANIdentity
struct BrickletCANIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletCAN
"""
Communicates with CAN bus devices
"""
mutable struct BrickletCAN <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletCAN(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_can")
        deviceInternal = package.BrickletCAN(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_frame
"""
    $(SIGNATURES)

Writes a data or remote frame to the write buffer to be transmitted over the
CAN transceiver.

The Bricklet supports the standard 11-bit (CAN 2.0A) and the additional extended
18-bit (CAN 2.0B) identifiers. For standard frames the Bricklet uses bit 0 to 10
from the ``identifier`` parameter as standard 11-bit identifier. For extended
frames the Bricklet additionally uses bit 11 to 28 from the ``identifier``
parameter as extended 18-bit identifier.

For remote frames the ``data`` parameter is ignored.

Returns *true* if the frame was successfully added to the write buffer. Returns
*false* if the frame could not be added because write buffer is already full.

The write buffer can overflow if frames are written to it at a higher rate
than the Bricklet can transmitted them over the CAN transceiver. This may
happen if the CAN transceiver is configured as read-only or is using a low baud
rate (see :func:`Set Configuration`). It can also happen if the CAN bus is
congested and the frame cannot be transmitted because it constantly loses
arbitration or because the CAN transceiver is currently disabled due to a high
write error level (see :func:`Get Error Log`).
"""
function write_frame(device::BrickletCAN, frame_type, identifier, data, length)
    return device.deviceInternal.write_frame(frame_type, identifier, data, length)
end

export read_frame
"""
    $(SIGNATURES)

Tries to read the next data or remote frame from the read buffer and return it.
If a frame was successfully read, then the ``success`` return value is set to
*true* and the other return values contain the frame. If the read buffer is
empty and no frame could be read, then the ``success`` return value is set to
*false* and the other return values contain invalid data.

The ``identifier`` return value follows the identifier format described for
:func:`Write Frame`.

For remote frames the ``data`` return value always contains invalid data.

A configurable read filter can be used to define which frames should be
received by the CAN transceiver and put into the read buffer (see
:func:`Set Read Filter`).

Instead of polling with this function, you can also use callbacks. See the
:func:`Enable Frame Read Callback` function and the :cb:`Frame Read` callback.
"""
function read_frame(device::BrickletCAN)
    return device.deviceInternal.read_frame()
end

export enable_frame_read_callback
"""
    $(SIGNATURES)

Enables the :cb:`Frame Read` callback.

By default the callback is disabled. Enabling this callback will disable the :cb:`Frame Readable` callback.
"""
function enable_frame_read_callback(device::BrickletCAN)
    device.deviceInternal.enable_frame_read_callback()
end

export disable_frame_read_callback
"""
    $(SIGNATURES)

Disables the :cb:`Frame Read` callback.

By default the callback is disabled.
"""
function disable_frame_read_callback(device::BrickletCAN)
    device.deviceInternal.disable_frame_read_callback()
end

export is_frame_read_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Frame Read` callback is enabled, *false* otherwise.
"""
function is_frame_read_callback_enabled(device::BrickletCAN)
    return device.deviceInternal.is_frame_read_callback_enabled()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration for the CAN bus communication.

The baud rate can be configured in steps between 10 and 1000 kbit/s.

The CAN transceiver has three different modes:

* Normal: Reads from and writes to the CAN bus and performs active bus
  error detection and acknowledgement.
* Loopback: All reads and writes are performed internally. The transceiver
  is disconnected from the actual CAN bus.
* Read-Only: Only reads from the CAN bus, but does neither active bus error
  detection nor acknowledgement. Only the receiving part of the transceiver
  is connected to the CAN bus.

The write timeout has three different modes that define how a failed frame
transmission should be handled:

* One-Shot (= -1): Only one transmission attempt will be made. If the
  transmission fails then the frame is discarded.
* Infinite (= 0): Infinite transmission attempts will be made. The frame will
  never be discarded.
* Milliseconds (> 0): A limited number of transmission attempts will be made.
  If the frame could not be transmitted successfully after the configured
  number of milliseconds then the frame is discarded.
"""
function set_configuration(device::BrickletCAN, baud_rate, transceiver_mode, write_timeout)
    device.deviceInternal.set_configuration(baud_rate, transceiver_mode, write_timeout)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletCAN)
    return device.deviceInternal.get_configuration()
end

export set_read_filter
"""
    $(SIGNATURES)

Set the read filter configuration. This can be used to define which frames
should be received by the CAN transceiver and put into the read buffer.

The read filter has five different modes that define if and how the mask and
the two filters are applied:

* Disabled: No filtering is applied at all. All frames are received even
  incomplete and defective frames. This mode should be used for debugging only.
* Accept-All: All complete and error-free frames are received.
* Match-Standard: Only standard frames with a matching identifier are received.
* Match-Standard-and-Data: Only standard frames with matching identifier and
  data bytes are received.
* Match-Extended: Only extended frames with a matching identifier are received.

The mask and filters are used as bit masks. Their usage depends on the mode:

* Disabled: Mask and filters are ignored.
* Accept-All: Mask and filters are ignored.
* Match-Standard: Bit 0 to 10 (11 bits) of mask and filters are used to match
  the 11-bit identifier of standard frames.
* Match-Standard-and-Data: Bit 0 to 10 (11 bits) of mask and filters are used
  to match the 11-bit identifier of standard frames. Bit 11 to 18 (8 bits) and
  bit 19 to 26 (8 bits) of mask and filters are used to match the first and
  second data byte (if present) of standard frames.
* Match-Extended: Bit 0 to 10 (11 bits) of mask and filters are used
  to match the standard 11-bit identifier part of extended frames. Bit 11 to 28
  (18 bits) of mask and filters are used to match the extended 18-bit identifier
  part of extended frames.

The mask and filters are applied in this way: The mask is used to select the
identifier and data bits that should be compared to the corresponding filter
bits. All unselected bits are automatically accepted. All selected bits have
to match one of the filters to be accepted. If all bits for the selected mode
are accepted then the frame is accepted and is added to the read buffer.

.. csv-table::
 :header: "Mask Bit", "Filter Bit", "Identifier/Data Bit", "Result"
 :widths: 10, 10, 10, 10

 0, X, X, Accept
 1, 0, 0, Accept
 1, 0, 1, Reject
 1, 1, 0, Reject
 1, 1, 1, Accept

For example, to receive standard frames with identifier 0x123 only the mode can
be set to Match-Standard with 0x7FF as mask and 0x123 as filter 1 and filter 2.
The mask of 0x7FF selects all 11 identifier bits for matching so that the
identifier has to be exactly 0x123 to be accepted.

To accept identifier 0x123 and identifier 0x456 at the same time, just set
filter 2 to 0x456 and keep mask and filter 1 unchanged.
"""
function set_read_filter(device::BrickletCAN, mode, mask, filter1, filter2)
    device.deviceInternal.set_read_filter(mode, mask, filter1, filter2)
end

export get_read_filter
"""
    $(SIGNATURES)

Returns the read filter as set by :func:`Set Read Filter`.
"""
function get_read_filter(device::BrickletCAN)
    return device.deviceInternal.get_read_filter()
end

export get_error_log
"""
    $(SIGNATURES)

Returns information about different kinds of errors.

The write and read error levels indicate the current level of checksum,
acknowledgement, form, bit and stuffing errors during CAN bus write and read
operations.

When the write error level exceeds 255 then the CAN transceiver gets disabled
and no frames can be transmitted or received anymore. The CAN transceiver will
automatically be activated again after the CAN bus is idle for a while.

The write and read error levels are not available in read-only transceiver mode
(see :func:`Set Configuration`) and are reset to 0 as a side effect of changing
the configuration or the read filter.

The write timeout, read register and buffer overflow counts represents the
number of these errors:

* A write timeout occurs if a frame could not be transmitted before the
  configured write timeout expired (see :func:`Set Configuration`).
* A read register overflow occurs if the read register of the CAN transceiver
  still contains the last received frame when the next frame arrives. In this
  case the newly arrived frame is lost. This happens if the CAN transceiver
  receives more frames than the Bricklet can handle. Using the read filter
  (see :func:`Set Read Filter`) can help to reduce the amount of received frames.
  This count is not exact, but a lower bound, because the Bricklet might not
  able detect all overflows if they occur in rapid succession.
* A read buffer overflow occurs if the read buffer of the Bricklet is already
  full when the next frame should be read from the read register of the CAN
  transceiver. In this case the frame in the read register is lost. This
  happens if the CAN transceiver receives more frames to be added to the read
  buffer than are removed from the read buffer using the :func:`Read Frame`
  function. Using the :cb:`Frame Read` callback ensures that the read buffer
  can not overflow.
"""
function get_error_log(device::BrickletCAN)
    return device.deviceInternal.get_error_log()
end

export set_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Enables/disables the :cb:`Frame Readable` callback.

By default the callback is disabled. Enabling this callback will disable the :cb:`Frame Read` callback.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_frame_readable_callback_configuration(device::BrickletCAN, enabled)
    device.deviceInternal.set_frame_readable_callback_configuration(enabled)
end

export get_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Frame Readable` callback is enabled, *false* otherwise.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_frame_readable_callback_configuration(device::BrickletCAN)
    return device.deviceInternal.get_frame_readable_callback_configuration()
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
function get_identity(device::BrickletCAN)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletCAN, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
