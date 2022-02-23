


export BrickletLaserRangeFinderV2DistanceCallbackConfiguration
struct BrickletLaserRangeFinderV2DistanceCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletLaserRangeFinderV2VelocityCallbackConfiguration
struct BrickletLaserRangeFinderV2VelocityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletLaserRangeFinderV2Configuration
struct BrickletLaserRangeFinderV2Configuration
    acquisition_count::Integer
    enable_quick_termination::Bool
    threshold_value::Integer
    measurement_frequency::Integer
end

export BrickletLaserRangeFinderV2MovingAverage
struct BrickletLaserRangeFinderV2MovingAverage
    distance_average_length::Integer
    velocity_average_length::Integer
end

export BrickletLaserRangeFinderV2SPITFPErrorCount
struct BrickletLaserRangeFinderV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletLaserRangeFinderV2Identity
struct BrickletLaserRangeFinderV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLaserRangeFinderV2
"""
Measures distance up to 40m with laser light
"""
mutable struct BrickletLaserRangeFinderV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLaserRangeFinderV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_laser_range_finder_v2")
        deviceInternal = package.BrickletLaserRangeFinderV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_distance
"""
    $(SIGNATURES)

Returns the measured distance.

The laser has to be enabled, see :func:`Set Enable`.


If you want to get the value periodically, it is recommended to use the
:cb:`Distance` callback. You can set the callback configuration
with :func:`Set Distance Callback Configuration`.
"""
function get_distance(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_distance()
end

export set_distance_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Distance` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Distance` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_distance_callback_configuration(device::BrickletLaserRangeFinderV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_distance_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_distance_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Distance Callback Configuration`.
"""
function get_distance_callback_configuration(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_distance_callback_configuration()
end

export get_velocity
"""
    $(SIGNATURES)

Returns the measured velocity. The value has a range of -12800 to 12700
and is given in 1/100 m/s.

The velocity measurement only produces stables results if a fixed
measurement rate (see :func:`Set Configuration`) is configured. Also the laser
has to be enabled, see :func:`Set Enable`.


If you want to get the value periodically, it is recommended to use the
:cb:`Velocity` callback. You can set the callback configuration
with :func:`Set Velocity Callback Configuration`.
"""
function get_velocity(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_velocity()
end

export set_velocity_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Velocity` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Velocity` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_velocity_callback_configuration(device::BrickletLaserRangeFinderV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_velocity_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_velocity_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Velocity Callback Configuration`.
"""
function get_velocity_callback_configuration(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_velocity_callback_configuration()
end

export set_enable
"""
    $(SIGNATURES)

Enables the laser of the LIDAR if set to *true*.

We recommend that you wait 250ms after enabling the laser before
the first call of :func:`Get Distance` to ensure stable measurements.
"""
function set_enable(device::BrickletLaserRangeFinderV2, enable)
    device.deviceInternal.set_enable(enable)
end

export get_enable
"""
    $(SIGNATURES)

Returns the value as set by :func:`Set Enable`.
"""
function get_enable(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_enable()
end

export set_configuration
"""
    $(SIGNATURES)

The **Acquisition Count** defines the number of times the Laser Range Finder Bricklet
will integrate acquisitions to find a correlation record peak. With a higher count,
the Bricklet can measure longer distances. With a lower count, the rate increases. The
allowed values are 1-255.

If you set **Enable Quick Termination** to true, the distance measurement will be terminated
early if a high peak was already detected. This means that a higher measurement rate can be achieved
and long distances can be measured at the same time. However, the chance of false-positive
distance measurements increases.

Normally the distance is calculated with a detection algorithm that uses peak value,
signal strength and noise. You can however also define a fixed **Threshold Value**.
Set this to a low value if you want to measure the distance to something that has
very little reflection (e.g. glass) and set it to a high value if you want to measure
the distance to something with a very high reflection (e.g. mirror). Set this to 0 to
use the default algorithm. The other allowed values are 1-255.

Set the **Measurement Frequency** to force a fixed measurement rate. If set to 0,
the Laser Range Finder Bricklet will use the optimal frequency according to the other
configurations and the actual measured distance. Since the rate is not fixed in this case,
the velocity measurement is not stable. For a stable velocity measurement you should
set a fixed measurement frequency. The lower the frequency, the higher is the resolution
of the calculated velocity. The allowed values are 10Hz-500Hz (and 0 to turn the fixed
frequency off).

The default values for Acquisition Count, Enable Quick Termination, Threshold Value and
Measurement Frequency are 128, false, 0 and 0.
"""
function set_configuration(device::BrickletLaserRangeFinderV2, acquisition_count, enable_quick_termination, threshold_value, measurement_frequency)
    device.deviceInternal.set_configuration(acquisition_count, enable_quick_termination, threshold_value, measurement_frequency)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_configuration()
end

export set_moving_average
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the distance and velocity.

Setting the length to 0 will turn the averaging completely off. With less
averaging, there is more noise on the data.
"""
function set_moving_average(device::BrickletLaserRangeFinderV2, distance_average_length, velocity_average_length)
    device.deviceInternal.set_moving_average(distance_average_length, velocity_average_length)
end

export get_moving_average
"""
    $(SIGNATURES)

Returns the length moving average as set by :func:`Set Moving Average`.
"""
function get_moving_average(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_moving_average()
end

export set_offset_calibration
"""
    $(SIGNATURES)

The offset is added to the measured distance.
It is saved in non-volatile memory, you only have to set it once.

The Bricklet comes with a per-sensor factory-calibrated offset value,
you should not have to call this function.

If you want to re-calibrate the offset you first have to set it to 0.
Calculate the offset by measuring the distance to a known distance
and set it again.
"""
function set_offset_calibration(device::BrickletLaserRangeFinderV2, offset)
    device.deviceInternal.set_offset_calibration(offset)
end

export get_offset_calibration
"""
    $(SIGNATURES)

Returns the offset value as set by :func:`Set Offset Calibration`.
"""
function get_offset_calibration(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_offset_calibration()
end

export set_distance_led_config
"""
    $(SIGNATURES)

Configures the distance LED to be either turned off, turned on, blink in
heartbeat mode or show the distance (brighter = object is nearer).
"""
function set_distance_led_config(device::BrickletLaserRangeFinderV2, config)
    device.deviceInternal.set_distance_led_config(config)
end

export get_distance_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set Distance LED Config`
"""
function get_distance_led_config(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_distance_led_config()
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
function get_spitfp_error_count(device::BrickletLaserRangeFinderV2)
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
function set_bootloader_mode(device::BrickletLaserRangeFinderV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletLaserRangeFinderV2)
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
function set_write_firmware_pointer(device::BrickletLaserRangeFinderV2, pointer)
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
function write_firmware(device::BrickletLaserRangeFinderV2, data)
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
function set_status_led_config(device::BrickletLaserRangeFinderV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletLaserRangeFinderV2)
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
function get_chip_temperature(device::BrickletLaserRangeFinderV2)
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
function reset(device::BrickletLaserRangeFinderV2)
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
function write_uid(device::BrickletLaserRangeFinderV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletLaserRangeFinderV2)
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
function get_identity(device::BrickletLaserRangeFinderV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLaserRangeFinderV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
