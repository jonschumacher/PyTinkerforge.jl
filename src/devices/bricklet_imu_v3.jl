


export BrickletIMUV3Acceleration
struct BrickletIMUV3Acceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickletIMUV3MagneticField
struct BrickletIMUV3MagneticField
    x::Integer
    y::Integer
    z::Integer
end

export BrickletIMUV3AngularVelocity
struct BrickletIMUV3AngularVelocity
    x::Integer
    y::Integer
    z::Integer
end

export BrickletIMUV3Orientation
struct BrickletIMUV3Orientation
    heading::Integer
    roll::Integer
    pitch::Integer
end

export BrickletIMUV3LinearAcceleration
struct BrickletIMUV3LinearAcceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickletIMUV3GravityVector
struct BrickletIMUV3GravityVector
    x::Integer
    y::Integer
    z::Integer
end

export BrickletIMUV3Quaternion
struct BrickletIMUV3Quaternion
    w::Integer
    x::Integer
    y::Integer
    z::Integer
end

export BrickletIMUV3AllData
struct BrickletIMUV3AllData
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

export BrickletIMUV3SensorConfiguration
struct BrickletIMUV3SensorConfiguration
    magnetometer_rate::Integer
    gyroscope_range::Integer
    gyroscope_bandwidth::Integer
    accelerometer_range::Integer
    accelerometer_bandwidth::Integer
end

export BrickletIMUV3AccelerationCallbackConfiguration
struct BrickletIMUV3AccelerationCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3MagneticFieldCallbackConfiguration
struct BrickletIMUV3MagneticFieldCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3AngularVelocityCallbackConfiguration
struct BrickletIMUV3AngularVelocityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3TemperatureCallbackConfiguration
struct BrickletIMUV3TemperatureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3OrientationCallbackConfiguration
struct BrickletIMUV3OrientationCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3LinearAccelerationCallbackConfiguration
struct BrickletIMUV3LinearAccelerationCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3GravityVectorCallbackConfiguration
struct BrickletIMUV3GravityVectorCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3QuaternionCallbackConfiguration
struct BrickletIMUV3QuaternionCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3AllDataCallbackConfiguration
struct BrickletIMUV3AllDataCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIMUV3SPITFPErrorCount
struct BrickletIMUV3SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIMUV3Identity
struct BrickletIMUV3Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIMUV3
"""
Full fledged AHRS with 9 degrees of freedom
"""
mutable struct BrickletIMUV3 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIMUV3(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_imu_v3")
        deviceInternal = package.BrickletIMUV3(uid, ipcon.ipconInternal)

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
:func:`Set Acceleration Callback Configuration`.
"""
function get_acceleration(device::BrickletIMUV3)
    return device.deviceInternal.get_acceleration()
end

export get_magnetic_field
"""
    $(SIGNATURES)

Returns the calibrated magnetic field from the magnetometer for the
x, y and z axis.

If you want to get the magnetic field periodically, it is recommended
to use the :cb:`Magnetic Field` callback and set the period with
:func:`Set Magnetic Field Callback Configuration`.
"""
function get_magnetic_field(device::BrickletIMUV3)
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
:func:`Set Angular Velocity Callback Configuration`.
"""
function get_angular_velocity(device::BrickletIMUV3)
    return device.deviceInternal.get_angular_velocity()
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of the IMU Brick.
The temperature is measured in the core of the BNO055 IC, it is not the
ambient temperature
"""
function get_temperature(device::BrickletIMUV3)
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
:func:`Set Orientation Callback Configuration`.
"""
function get_orientation(device::BrickletIMUV3)
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
:func:`Set Linear Acceleration Callback Configuration`.
"""
function get_linear_acceleration(device::BrickletIMUV3)
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
:func:`Set Gravity Vector Callback Configuration`.
"""
function get_gravity_vector(device::BrickletIMUV3)
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
:func:`Set Quaternion Callback Configuration`.
"""
function get_quaternion(device::BrickletIMUV3)
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
:func:`Set All Data Callback Configuration`.
"""
function get_all_data(device::BrickletIMUV3)
    return device.deviceInternal.get_all_data()
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
function save_calibration(device::BrickletIMUV3)
    return device.deviceInternal.save_calibration()
end

export set_sensor_configuration
"""
    $(SIGNATURES)

Sets the available sensor configuration for the Magnetometer, Gyroscope and
Accelerometer. The Accelerometer Range is user selectable in all fusion modes,
all other configurations are auto-controlled in fusion mode.
"""
function set_sensor_configuration(device::BrickletIMUV3, magnetometer_rate, gyroscope_range, gyroscope_bandwidth, accelerometer_range, accelerometer_bandwidth)
    device.deviceInternal.set_sensor_configuration(magnetometer_rate, gyroscope_range, gyroscope_bandwidth, accelerometer_range, accelerometer_bandwidth)
end

export get_sensor_configuration
"""
    $(SIGNATURES)

Returns the sensor configuration as set by :func:`Set Sensor Configuration`.
"""
function get_sensor_configuration(device::BrickletIMUV3)
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
"""
function set_sensor_fusion_mode(device::BrickletIMUV3, mode)
    device.deviceInternal.set_sensor_fusion_mode(mode)
end

export get_sensor_fusion_mode
"""
    $(SIGNATURES)

Returns the sensor fusion mode as set by :func:`Set Sensor Fusion Mode`.
"""
function get_sensor_fusion_mode(device::BrickletIMUV3)
    return device.deviceInternal.get_sensor_fusion_mode()
end

export set_acceleration_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Acceleration` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_acceleration_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_acceleration_callback_configuration(period, value_has_to_change)
end

export get_acceleration_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Acceleration Callback Configuration`.
"""
function get_acceleration_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_acceleration_callback_configuration()
end

export set_magnetic_field_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Magnetic Field` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_magnetic_field_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_magnetic_field_callback_configuration(period, value_has_to_change)
end

export get_magnetic_field_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Magnetic Field Callback Configuration`.
"""
function get_magnetic_field_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_magnetic_field_callback_configuration()
end

export set_angular_velocity_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Angular Velocity` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_angular_velocity_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_angular_velocity_callback_configuration(period, value_has_to_change)
end

export get_angular_velocity_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Angular Velocity Callback Configuration`.
"""
function get_angular_velocity_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_angular_velocity_callback_configuration()
end

export set_temperature_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Temperature` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_temperature_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_temperature_callback_configuration(period, value_has_to_change)
end

export get_temperature_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Temperature Callback Configuration`.
"""
function get_temperature_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_temperature_callback_configuration()
end

export set_orientation_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Orientation` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_orientation_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_orientation_callback_configuration(period, value_has_to_change)
end

export get_orientation_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Orientation Callback Configuration`.
"""
function get_orientation_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_orientation_callback_configuration()
end

export set_linear_acceleration_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Linear Acceleration` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_linear_acceleration_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_linear_acceleration_callback_configuration(period, value_has_to_change)
end

export get_linear_acceleration_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Linear Acceleration Callback Configuration`.
"""
function get_linear_acceleration_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_linear_acceleration_callback_configuration()
end

export set_gravity_vector_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Gravity Vector` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_gravity_vector_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_gravity_vector_callback_configuration(period, value_has_to_change)
end

export get_gravity_vector_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Gravity Vector Callback Configuration`.
"""
function get_gravity_vector_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_gravity_vector_callback_configuration()
end

export set_quaternion_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Quaternion` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_quaternion_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_quaternion_callback_configuration(period, value_has_to_change)
end

export get_quaternion_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Quaternion Callback Configuration`.
"""
function get_quaternion_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_quaternion_callback_configuration()
end

export set_all_data_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`All Data` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_all_data_callback_configuration(device::BrickletIMUV3, period, value_has_to_change)
    device.deviceInternal.set_all_data_callback_configuration(period, value_has_to_change)
end

export get_all_data_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set All Data Callback Configuration`.
"""
function get_all_data_callback_configuration(device::BrickletIMUV3)
    return device.deviceInternal.get_all_data_callback_configuration()
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
function get_spitfp_error_count(device::BrickletIMUV3)
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
function set_bootloader_mode(device::BrickletIMUV3, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIMUV3)
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
function set_write_firmware_pointer(device::BrickletIMUV3, pointer)
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
function write_firmware(device::BrickletIMUV3, data)
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
function set_status_led_config(device::BrickletIMUV3, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIMUV3)
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
function get_chip_temperature(device::BrickletIMUV3)
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
function reset(device::BrickletIMUV3)
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
function write_uid(device::BrickletIMUV3, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIMUV3)
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
function get_identity(device::BrickletIMUV3)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIMUV3, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
