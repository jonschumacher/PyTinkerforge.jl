


export BrickIMUV2Acceleration
struct BrickIMUV2Acceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUV2MagneticField
struct BrickIMUV2MagneticField
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUV2AngularVelocity
struct BrickIMUV2AngularVelocity
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUV2Orientation
struct BrickIMUV2Orientation
    heading::Integer
    roll::Integer
    pitch::Integer
end

export BrickIMUV2LinearAcceleration
struct BrickIMUV2LinearAcceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUV2GravityVector
struct BrickIMUV2GravityVector
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUV2Quaternion
struct BrickIMUV2Quaternion
    w::Integer
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUV2AllData
struct BrickIMUV2AllData
    acceleration::Vector{Integer}
    magnetic_field::Vector{Integer}
    angular_velocity::Vector{Integer}
    euler_angle::Vector{Integer}
    quaternion::Vector{Integer}
    linear_acceleration::Vector{Integer}
    gravity_vector::Vector{Integer}
    temperature::Integer
    calibration_status::Integer
end

export BrickIMUV2SensorConfiguration
struct BrickIMUV2SensorConfiguration
    magnetometer_rate::Integer
    gyroscope_range::Integer
    gyroscope_bandwidth::Integer
    accelerometer_range::Integer
    accelerometer_bandwidth::Integer
end

export BrickIMUV2SPITFPBaudrateConfig
struct BrickIMUV2SPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickIMUV2SPITFPErrorCount
struct BrickIMUV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickIMUV2Protocol1BrickletName
struct BrickIMUV2Protocol1BrickletName
    protocol_version::Integer
    firmware_version::Vector{Integer}
    name::String
end

export BrickIMUV2Identity
struct BrickIMUV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickIMUV2
"""
Full fledged AHRS with 9 degrees of freedom
"""
mutable struct BrickIMUV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickIMUV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_imu_v2")
        deviceInternal = package.BrickIMUV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_acceleration
"""
    $(SIGNATURES)

Returns the calibrated acceleration from the accelerometer for the
x, y and z axis. The acceleration is in the range configured with
:func:`Set Sensor Configuration`.

If you want to get the acceleration periodically, it is recommended
to use the :cb:`Acceleration` callback and set the period with
:func:`Set Acceleration Period`.
"""
function get_acceleration(device::BrickIMUV2)
    return device.deviceInternal.get_acceleration()
end

export get_magnetic_field
"""
    $(SIGNATURES)

Returns the calibrated magnetic field from the magnetometer for the
x, y and z axis.

If you want to get the magnetic field periodically, it is recommended
to use the :cb:`Magnetic Field` callback and set the period with
:func:`Set Magnetic Field Period`.
"""
function get_magnetic_field(device::BrickIMUV2)
    return device.deviceInternal.get_magnetic_field()
end

export get_angular_velocity
"""
    $(SIGNATURES)

Returns the calibrated angular velocity from the gyroscope for the
x, y and z axis. The angular velocity is in the range configured with
:func:`Set Sensor Configuration`.

If you want to get the angular velocity periodically, it is recommended
to use the :cb:`Angular Velocity` acallback nd set the period with
:func:`Set Angular Velocity Period`.
"""
function get_angular_velocity(device::BrickIMUV2)
    return device.deviceInternal.get_angular_velocity()
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of the IMU Brick.
The temperature is measured in the core of the BNO055 IC, it is not the
ambient temperature
"""
function get_temperature(device::BrickIMUV2)
    return device.deviceInternal.get_temperature()
end

export get_orientation
"""
    $(SIGNATURES)

Returns the current orientation (heading, roll, pitch) of the IMU Brick as
independent Euler angles. Note that Euler angles always
experience a `gimbal lock <https://en.wikipedia.org/wiki/Gimbal_lock>`__.
We recommend that you use quaternions instead, if you need the absolute
orientation.

If you want to get the orientation periodically, it is recommended
to use the :cb:`Orientation` callback and set the period with
:func:`Set Orientation Period`.
"""
function get_orientation(device::BrickIMUV2)
    return device.deviceInternal.get_orientation()
end

export get_linear_acceleration
"""
    $(SIGNATURES)

Returns the linear acceleration of the IMU Brick for the
x, y and z axis. The acceleration is in the range configured with
:func:`Set Sensor Configuration`.

The linear acceleration is the acceleration in each of the three
axis of the IMU Brick with the influences of gravity removed.

It is also possible to get the gravity vector with the influence of linear
acceleration removed, see :func:`Get Gravity Vector`.

If you want to get the linear acceleration periodically, it is recommended
to use the :cb:`Linear Acceleration` callback and set the period with
:func:`Set Linear Acceleration Period`.
"""
function get_linear_acceleration(device::BrickIMUV2)
    return device.deviceInternal.get_linear_acceleration()
end

export get_gravity_vector
"""
    $(SIGNATURES)

Returns the current gravity vector of the IMU Brick for the
x, y and z axis.

The gravity vector is the acceleration that occurs due to gravity.
Influences of additional linear acceleration are removed.

It is also possible to get the linear acceleration with the influence
of gravity removed, see :func:`Get Linear Acceleration`.

If you want to get the gravity vector periodically, it is recommended
to use the :cb:`Gravity Vector` callback and set the period with
:func:`Set Gravity Vector Period`.
"""
function get_gravity_vector(device::BrickIMUV2)
    return device.deviceInternal.get_gravity_vector()
end

export get_quaternion
"""
    $(SIGNATURES)

Returns the current orientation (w, x, y, z) of the IMU Brick as
`quaternions <https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation>`__.

You have to divide the return values by 16383 (14 bit) to get
the usual range of -1.0 to +1.0 for quaternions.

If you want to get the quaternions periodically, it is recommended
to use the :cb:`Quaternion` callback and set the period with
:func:`Set Quaternion Period`.
"""
function get_quaternion(device::BrickIMUV2)
    return device.deviceInternal.get_quaternion()
end

export get_all_data
"""
    $(SIGNATURES)

Return all of the available data of the IMU Brick.

* acceleration (see :func:`Get Acceleration`)
* magnetic field (see :func:`Get Magnetic Field`)
* angular velocity (see :func:`Get Angular Velocity`)
* Euler angles (see :func:`Get Orientation`)
* quaternion (see :func:`Get Quaternion`)
* linear acceleration (see :func:`Get Linear Acceleration`)
* gravity vector (see :func:`Get Gravity Vector`)
* temperature (see :func:`Get Temperature`)
* calibration status (see below)

The calibration status consists of four pairs of two bits. Each pair
of bits represents the status of the current calibration.

* bit 0-1: Magnetometer
* bit 2-3: Accelerometer
* bit 4-5: Gyroscope
* bit 6-7: System

A value of 0 means for "not calibrated" and a value of 3 means
"fully calibrated". In your program you should always be able to
ignore the calibration status, it is used by the calibration
window of the Brick Viewer and it can be ignored after the first
calibration. See the documentation in the calibration window for
more information regarding the calibration of the IMU Brick.

If you want to get the data periodically, it is recommended
to use the :cb:`All Data` callback and set the period with
:func:`Set All Data Period`.
"""
function get_all_data(device::BrickIMUV2)
    return device.deviceInternal.get_all_data()
end

export leds_on
"""
    $(SIGNATURES)

Turns the orientation and direction LEDs of the IMU Brick on.
"""
function leds_on(device::BrickIMUV2)
    device.deviceInternal.leds_on()
end

export leds_off
"""
    $(SIGNATURES)

Turns the orientation and direction LEDs of the IMU Brick off.
"""
function leds_off(device::BrickIMUV2)
    device.deviceInternal.leds_off()
end

export are_leds_on
"""
    $(SIGNATURES)

Returns *true* if the orientation and direction LEDs of the IMU Brick
are on, *false* otherwise.
"""
function are_leds_on(device::BrickIMUV2)
    return device.deviceInternal.are_leds_on()
end

export save_calibration
"""
    $(SIGNATURES)

A call of this function saves the current calibration to be used
as a starting point for the next restart of continuous calibration
of the IMU Brick.

A return value of *true* means that the calibration could be used and
*false* means that it could not be used (this happens if the calibration
status is not "fully calibrated").

This function is used by the calibration window of the Brick Viewer, you
should not need to call it in your program.
"""
function save_calibration(device::BrickIMUV2)
    return device.deviceInternal.save_calibration()
end

export set_acceleration_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Acceleration` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_acceleration_period(device::BrickIMUV2, period)
    device.deviceInternal.set_acceleration_period(period)
end

export get_acceleration_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Acceleration Period`.
"""
function get_acceleration_period(device::BrickIMUV2)
    return device.deviceInternal.get_acceleration_period()
end

export set_magnetic_field_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Magnetic Field` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_magnetic_field_period(device::BrickIMUV2, period)
    device.deviceInternal.set_magnetic_field_period(period)
end

export get_magnetic_field_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Magnetic Field Period`.
"""
function get_magnetic_field_period(device::BrickIMUV2)
    return device.deviceInternal.get_magnetic_field_period()
end

export set_angular_velocity_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Angular Velocity` callback is
triggered periodically. A value of 0 turns the callback off.
"""
function set_angular_velocity_period(device::BrickIMUV2, period)
    device.deviceInternal.set_angular_velocity_period(period)
end

export get_angular_velocity_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Angular Velocity Period`.
"""
function get_angular_velocity_period(device::BrickIMUV2)
    return device.deviceInternal.get_angular_velocity_period()
end

export set_temperature_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Temperature` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_temperature_period(device::BrickIMUV2, period)
    device.deviceInternal.set_temperature_period(period)
end

export get_temperature_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Temperature Period`.
"""
function get_temperature_period(device::BrickIMUV2)
    return device.deviceInternal.get_temperature_period()
end

export set_orientation_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Orientation` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_orientation_period(device::BrickIMUV2, period)
    device.deviceInternal.set_orientation_period(period)
end

export get_orientation_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Orientation Period`.
"""
function get_orientation_period(device::BrickIMUV2)
    return device.deviceInternal.get_orientation_period()
end

export set_linear_acceleration_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Linear Acceleration` callback is
triggered periodically. A value of 0 turns the callback off.
"""
function set_linear_acceleration_period(device::BrickIMUV2, period)
    device.deviceInternal.set_linear_acceleration_period(period)
end

export get_linear_acceleration_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Linear Acceleration Period`.
"""
function get_linear_acceleration_period(device::BrickIMUV2)
    return device.deviceInternal.get_linear_acceleration_period()
end

export set_gravity_vector_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Gravity Vector` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_gravity_vector_period(device::BrickIMUV2, period)
    device.deviceInternal.set_gravity_vector_period(period)
end

export get_gravity_vector_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Gravity Vector Period`.
"""
function get_gravity_vector_period(device::BrickIMUV2)
    return device.deviceInternal.get_gravity_vector_period()
end

export set_quaternion_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Quaternion` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_quaternion_period(device::BrickIMUV2, period)
    device.deviceInternal.set_quaternion_period(period)
end

export get_quaternion_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Quaternion Period`.
"""
function get_quaternion_period(device::BrickIMUV2)
    return device.deviceInternal.get_quaternion_period()
end

export set_all_data_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`All Data` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_all_data_period(device::BrickIMUV2, period)
    device.deviceInternal.set_all_data_period(period)
end

export get_all_data_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set All Data Period`.
"""
function get_all_data_period(device::BrickIMUV2)
    return device.deviceInternal.get_all_data_period()
end

export set_sensor_configuration
"""
    $(SIGNATURES)

Sets the available sensor configuration for the Magnetometer, Gyroscope and
Accelerometer. The Accelerometer Range is user selectable in all fusion modes,
all other configurations are auto-controlled in fusion mode.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_sensor_configuration(device::BrickIMUV2, magnetometer_rate, gyroscope_range, gyroscope_bandwidth, accelerometer_range, accelerometer_bandwidth)
    device.deviceInternal.set_sensor_configuration(magnetometer_rate, gyroscope_range, gyroscope_bandwidth, accelerometer_range, accelerometer_bandwidth)
end

export get_sensor_configuration
"""
    $(SIGNATURES)

Returns the sensor configuration as set by :func:`Set Sensor Configuration`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_sensor_configuration(device::BrickIMUV2)
    return device.deviceInternal.get_sensor_configuration()
end

export set_sensor_fusion_mode
"""
    $(SIGNATURES)

If the fusion mode is turned off, the functions :func:`Get Acceleration`,
:func:`Get Magnetic Field` and :func:`Get Angular Velocity` return uncalibrated
and uncompensated sensor data. All other sensor data getters return no data.

Since firmware version 2.0.6 you can also use a fusion mode without magnetometer.
In this mode the calculated orientation is relative (with magnetometer it is
absolute with respect to the earth). However, the calculation can't be influenced
by spurious magnetic fields.

Since firmware version 2.0.13 you can also use a fusion mode without fast
magnetometer calibration. This mode is the same as the normal fusion mode,
but the fast magnetometer calibration is turned off. So to find the orientation
the first time will likely take longer, but small magnetic influences might
not affect the automatic calibration as much.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_sensor_fusion_mode(device::BrickIMUV2, mode)
    device.deviceInternal.set_sensor_fusion_mode(mode)
end

export get_sensor_fusion_mode
"""
    $(SIGNATURES)

Returns the sensor fusion mode as set by :func:`Set Sensor Fusion Mode`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_sensor_fusion_mode(device::BrickIMUV2)
    return device.deviceInternal.get_sensor_fusion_mode()
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

.. versionadded:: 2.0.10\$nbsp;(Firmware)
"""
function set_spitfp_baudrate_config(device::BrickIMUV2, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.

.. versionadded:: 2.0.10\$nbsp;(Firmware)
"""
function get_spitfp_baudrate_config(device::BrickIMUV2)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export get_send_timeout_count
"""
    $(SIGNATURES)

Returns the timeout count for the different communication methods.

The methods 0-2 are available for all Bricks, 3-7 only for Master Bricks.

This function is mostly used for debugging during development, in normal operation
the counters should nearly always stay at 0.

.. versionadded:: 2.0.7\$nbsp;(Firmware)
"""
function get_send_timeout_count(device::BrickIMUV2, communication_method)
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

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function set_spitfp_baudrate(device::BrickIMUV2, bricklet_port, baudrate)
    device.deviceInternal.set_spitfp_baudrate(bricklet_port, baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate for a given Bricklet port, see :func:`Set SPITFP Baudrate`.

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_spitfp_baudrate(device::BrickIMUV2, bricklet_port)
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

.. versionadded:: 2.0.5\$nbsp;(Firmware)
"""
function get_spitfp_error_count(device::BrickIMUV2, bricklet_port)
    return device.deviceInternal.get_spitfp_error_count(bricklet_port)
end

export enable_status_led
"""
    $(SIGNATURES)

Enables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.
"""
function enable_status_led(device::BrickIMUV2)
    device.deviceInternal.enable_status_led()
end

export disable_status_led
"""
    $(SIGNATURES)

Disables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.
"""
function disable_status_led(device::BrickIMUV2)
    device.deviceInternal.disable_status_led()
end

export is_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the status LED is enabled, *false* otherwise.
"""
function is_status_led_enabled(device::BrickIMUV2)
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
function get_protocol1_bricklet_name(device::BrickIMUV2, port)
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
function get_chip_temperature(device::BrickIMUV2)
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
function reset(device::BrickIMUV2)
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
function write_bricklet_plugin(device::BrickIMUV2, port, offset, chunk)
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
function read_bricklet_plugin(device::BrickIMUV2, port, offset)
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
function get_identity(device::BrickIMUV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickIMUV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
