


export BrickletLaserRangeFinderDistanceCallbackThreshold
struct BrickletLaserRangeFinderDistanceCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletLaserRangeFinderVelocityCallbackThreshold
struct BrickletLaserRangeFinderVelocityCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletLaserRangeFinderMovingAverage
struct BrickletLaserRangeFinderMovingAverage
    distance_average_length::Integer
    velocity_average_length::Integer
end

export BrickletLaserRangeFinderConfiguration
struct BrickletLaserRangeFinderConfiguration
    acquisition_count::Integer
    enable_quick_termination::Bool
    threshold_value::Integer
    measurement_frequency::Integer
end

export BrickletLaserRangeFinderIdentity
struct BrickletLaserRangeFinderIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLaserRangeFinder
"""
Measures distance up to 40m with laser light
"""
mutable struct BrickletLaserRangeFinder <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLaserRangeFinder(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_laser_range_finder")
        deviceInternal = package.BrickletLaserRangeFinder(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_distance
"""
    $(SIGNATURES)

Returns the measured distance.

Sensor hardware version 1 (see :func:`Get Sensor Hardware Version`) cannot
measure distance and velocity at the same time. Therefore, the distance mode
has to be enabled using :func:`Set Mode`.
Sensor hardware version 3 can measure distance and velocity at the same
time. Also the laser has to be enabled, see :func:`Enable Laser`.

If you want to get the distance periodically, it is recommended to
use the :cb:`Distance` callback and set the period with
:func:`Set Distance Callback Period`.
"""
function get_distance(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_distance()
end

export get_velocity
"""
    $(SIGNATURES)

Returns the measured velocity.

Sensor hardware version 1 (see :func:`Get Sensor Hardware Version`) cannot
measure distance and velocity at the same time. Therefore, the velocity mode
has to be enabled using :func:`Set Mode`.
Sensor hardware version 3 can measure distance and velocity at the same
time, but the velocity measurement only produces stables results if a fixed
measurement rate (see :func:`Set Configuration`) is configured. Also the laser
has to be enabled, see :func:`Enable Laser`.

If you want to get the velocity periodically, it is recommended to
use the :cb:`Velocity` callback and set the period with
:func:`Set Velocity Callback Period`.
"""
function get_velocity(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_velocity()
end

export set_distance_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Distance` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Distance` callback is only triggered if the distance value has
changed since the last triggering.
"""
function set_distance_callback_period(device::BrickletLaserRangeFinder, period)
    device.deviceInternal.set_distance_callback_period(period)
end

export get_distance_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Distance Callback Period`.
"""
function get_distance_callback_period(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_distance_callback_period()
end

export set_velocity_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Velocity` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Velocity` callback is only triggered if the velocity value has
changed since the last triggering.
"""
function set_velocity_callback_period(device::BrickletLaserRangeFinder, period)
    device.deviceInternal.set_velocity_callback_period(period)
end

export get_velocity_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Velocity Callback Period`.
"""
function get_velocity_callback_period(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_velocity_callback_period()
end

export set_distance_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Distance Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the distance value is *outside* the min and max values"
 "'i'",    "Callback is triggered when the distance value is *inside* the min and max values"
 "'<'",    "Callback is triggered when the distance value is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the distance value is greater than the min value (max is ignored)"
"""
function set_distance_callback_threshold(device::BrickletLaserRangeFinder, option, min, max)
    device.deviceInternal.set_distance_callback_threshold(option, min, max)
end

export get_distance_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Distance Callback Threshold`.
"""
function get_distance_callback_threshold(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_distance_callback_threshold()
end

export set_velocity_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Velocity Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the velocity is *outside* the min and max values"
 "'i'",    "Callback is triggered when the velocity is *inside* the min and max values"
 "'<'",    "Callback is triggered when the velocity is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the velocity is greater than the min value (max is ignored)"
"""
function set_velocity_callback_threshold(device::BrickletLaserRangeFinder, option, min, max)
    device.deviceInternal.set_velocity_callback_threshold(option, min, max)
end

export get_velocity_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Velocity Callback Threshold`.
"""
function get_velocity_callback_threshold(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_velocity_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Distance Reached`,
* :cb:`Velocity Reached`,

are triggered, if the thresholds

* :func:`Set Distance Callback Threshold`,
* :func:`Set Velocity Callback Threshold`,

keep being reached.
"""
function set_debounce_period(device::BrickletLaserRangeFinder, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_debounce_period()
end

export set_moving_average
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the distance and velocity.

Setting the length to 0 will turn the averaging completely off. With less
averaging, there is more noise on the data.
"""
function set_moving_average(device::BrickletLaserRangeFinder, distance_average_length, velocity_average_length)
    device.deviceInternal.set_moving_average(distance_average_length, velocity_average_length)
end

export get_moving_average
"""
    $(SIGNATURES)

Returns the length moving average as set by :func:`Set Moving Average`.
"""
function get_moving_average(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_moving_average()
end

export set_mode
"""
    $(SIGNATURES)

.. note::
 This function is only available if you have a LIDAR-Lite sensor with hardware
 version 1. Use :func:`Set Configuration` for hardware version 3. You can check
 the sensor hardware version using :func:`Get Sensor Hardware Version`.

The LIDAR-Lite sensor (hardware version 1) has five different modes. One mode is
for distance measurements and four modes are for velocity measurements with
different ranges.

The following modes are available:

* 0: Distance is measured with resolution 1.0 cm and range 0-4000 cm
* 1: Velocity is measured with resolution 0.1 m/s and range is 0-12.7 m/s
* 2: Velocity is measured with resolution 0.25 m/s and range is 0-31.75 m/s
* 3: Velocity is measured with resolution 0.5 m/s and range is 0-63.5 m/s
* 4: Velocity is measured with resolution 1.0 m/s and range is 0-127 m/s
"""
function set_mode(device::BrickletLaserRangeFinder, mode)
    device.deviceInternal.set_mode(mode)
end

export get_mode
"""
    $(SIGNATURES)

Returns the mode as set by :func:`Set Mode`.
"""
function get_mode(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_mode()
end

export enable_laser
"""
    $(SIGNATURES)

Activates the laser of the LIDAR.

We recommend that you wait 250ms after enabling the laser before
the first call of :func:`Get Distance` to ensure stable measurements.
"""
function enable_laser(device::BrickletLaserRangeFinder)
    device.deviceInternal.enable_laser()
end

export disable_laser
"""
    $(SIGNATURES)

Deactivates the laser of the LIDAR.
"""
function disable_laser(device::BrickletLaserRangeFinder)
    device.deviceInternal.disable_laser()
end

export is_laser_enabled
"""
    $(SIGNATURES)

Returns *true* if the laser is enabled, *false* otherwise.
"""
function is_laser_enabled(device::BrickletLaserRangeFinder)
    return device.deviceInternal.is_laser_enabled()
end

export get_sensor_hardware_version
"""
    $(SIGNATURES)

Returns the LIDAR-Lite hardware version.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_sensor_hardware_version(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_sensor_hardware_version()
end

export set_configuration
"""
    $(SIGNATURES)

.. note::
 This function is only available if you have a LIDAR-Lite sensor with hardware
 version 3. Use :func:`Set Mode` for hardware version 1. You can check
 the sensor hardware version using :func:`Get Sensor Hardware Version`.

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

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_configuration(device::BrickletLaserRangeFinder, acquisition_count, enable_quick_termination, threshold_value, measurement_frequency)
    device.deviceInternal.set_configuration(acquisition_count, enable_quick_termination, threshold_value, measurement_frequency)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_configuration(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_configuration()
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
function get_identity(device::BrickletLaserRangeFinder)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLaserRangeFinder, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
