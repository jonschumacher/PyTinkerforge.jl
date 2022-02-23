


export BrickletThermalImagingHighContrastImageLowLevel
struct BrickletThermalImagingHighContrastImageLowLevel
    image_chunk_offset::Integer
    image_chunk_data::Vector{Integer}
end

export BrickletThermalImagingTemperatureImageLowLevel
struct BrickletThermalImagingTemperatureImageLowLevel
    image_chunk_offset::Integer
    image_chunk_data::Vector{Integer}
end

export BrickletThermalImagingStatistics
struct BrickletThermalImagingStatistics
    spotmeter_statistics::Vector{Integer}
    temperatures::Vector{Integer}
    resolution::Integer
    ffc_status::Integer
    temperature_warning::Vector{Bool}
end

export BrickletThermalImagingHighContrastConfig
struct BrickletThermalImagingHighContrastConfig
    region_of_interest::Vector{Integer}
    dampening_factor::Integer
    clip_limit::Vector{Integer}
    empty_counts::Integer
end

export BrickletThermalImagingFluxLinearParameters
struct BrickletThermalImagingFluxLinearParameters
    scene_emissivity::Integer
    temperature_background::Integer
    tau_window::Integer
    temperatur_window::Integer
    tau_atmosphere::Integer
    temperature_atmosphere::Integer
    reflection_window::Integer
    temperature_reflection::Integer
end

export BrickletThermalImagingSPITFPErrorCount
struct BrickletThermalImagingSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletThermalImagingIdentity
struct BrickletThermalImagingIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletThermalImaging
"""
80x60 pixel thermal imaging camera
"""
mutable struct BrickletThermalImaging <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletThermalImaging(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_thermal_imaging")
        deviceInternal = package.BrickletThermalImaging(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_high_contrast_image_low_level
"""
    $(SIGNATURES)

Returns the current high contrast image. See `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Thermal_Imaging.html#high-contrast-image-vs-temperature-image>`__
for the difference between
High Contrast and Temperature Image. If you don't know what to use
the High Contrast Image is probably right for you.

The data is organized as a 8-bit value 80x60 pixel matrix linearized in
a one-dimensional array. The data is arranged line by line from top left to
bottom right.

Each 8-bit value represents one gray-scale image pixel that can directly be
shown to a user on a display.

Before you can use this function you have to enable it with
:func:`Set Image Transfer Config`.
"""
function get_high_contrast_image_low_level(device::BrickletThermalImaging)
    return device.deviceInternal.get_high_contrast_image_low_level()
end

export get_temperature_image_low_level
"""
    $(SIGNATURES)

Returns the current temperature image. See `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Thermal_Imaging.html#high-contrast-image-vs-temperature-image>`__
for the difference between High Contrast and Temperature Image.
If you don't know what to use the High Contrast Image is probably right for you.

The data is organized as a 16-bit value 80x60 pixel matrix linearized in
a one-dimensional array. The data is arranged line by line from top left to
bottom right.

Each 16-bit value represents one temperature measurement in either
Kelvin/10 or Kelvin/100 (depending on the resolution set with :func:`Set Resolution`).

Before you can use this function you have to enable it with
:func:`Set Image Transfer Config`.
"""
function get_temperature_image_low_level(device::BrickletThermalImaging)
    return device.deviceInternal.get_temperature_image_low_level()
end

export get_statistics
"""
    $(SIGNATURES)

Returns the spotmeter statistics, various temperatures, current resolution and status bits.

The spotmeter statistics are:

* Index 0: Mean Temperature.
* Index 1: Maximum Temperature.
* Index 2: Minimum Temperature.
* Index 3: Pixel Count of spotmeter region of interest.

The temperatures are:

* Index 0: Focal Plain Array temperature.
* Index 1: Focal Plain Array temperature at last FFC (Flat Field Correction).
* Index 2: Housing temperature.
* Index 3: Housing temperature at last FFC.

The resolution is either `0 to 6553 Kelvin` or `0 to 655 Kelvin`. If the resolution is the former,
the temperatures are in Kelvin/10, if it is the latter the temperatures are in Kelvin/100.

FFC (Flat Field Correction) Status:

* FFC Never Commanded: Only seen on startup before first FFC.
* FFC Imminent: This state is entered 2 seconds prior to initiating FFC.
* FFC In Progress: Flat field correction is started (shutter moves in front of lens and back). Takes about 1 second.
* FFC Complete: Shutter is in waiting position again, FFC done.

Temperature warning bits:

* Index 0: Shutter lockout (if true shutter is locked out because temperature is outside -10°C to +65°C)
* Index 1: Overtemperature shut down imminent (goes true 10 seconds before shutdown)
"""
function get_statistics(device::BrickletThermalImaging)
    return device.deviceInternal.get_statistics()
end

export set_resolution
"""
    $(SIGNATURES)

Sets the resolution. The Thermal Imaging Bricklet can either measure

* from 0 to 6553 Kelvin (-273.15°C to +6279.85°C) with 0.1°C resolution or
* from 0 to 655 Kelvin (-273.15°C to +381.85°C) with 0.01°C resolution.

The accuracy is specified for -10°C to 450°C in the
first range and -10°C and 140°C in the second range.
"""
function set_resolution(device::BrickletThermalImaging, resolution)
    device.deviceInternal.set_resolution(resolution)
end

export get_resolution
"""
    $(SIGNATURES)

Returns the resolution as set by :func:`Set Resolution`.
"""
function get_resolution(device::BrickletThermalImaging)
    return device.deviceInternal.get_resolution()
end

export set_spotmeter_config
"""
    $(SIGNATURES)

Sets the spotmeter region of interest. The 4 values are

* Index 0: Column start (has to be smaller then Column end).
* Index 1: Row start (has to be smaller then Row end).
* Index 2: Column end (has to be smaller then 80).
* Index 3: Row end (has to be smaller then 60).

The spotmeter statistics can be read out with :func:`Get Statistics`.
"""
function set_spotmeter_config(device::BrickletThermalImaging, region_of_interest)
    device.deviceInternal.set_spotmeter_config(region_of_interest)
end

export get_spotmeter_config
"""
    $(SIGNATURES)

Returns the spotmeter config as set by :func:`Set Spotmeter Config`.
"""
function get_spotmeter_config(device::BrickletThermalImaging)
    return device.deviceInternal.get_spotmeter_config()
end

export set_high_contrast_config
"""
    $(SIGNATURES)

Sets the high contrast region of interest, dampening factor, clip limit and empty counts.
This config is only used in high contrast mode (see :func:`Set Image Transfer Config`).

The high contrast region of interest consists of four values:

* Index 0: Column start (has to be smaller or equal then Column end).
* Index 1: Row start (has to be smaller then Row end).
* Index 2: Column end (has to be smaller then 80).
* Index 3: Row end (has to be smaller then 60).

The algorithm to generate the high contrast image is applied to this region.

Dampening Factor: This parameter is the amount of temporal dampening applied to the HEQ
(history equalization) transformation function. An IIR filter of the form::

 (N / 256) * previous + ((256 - N) / 256) * current

is applied, and the HEQ dampening factor
represents the value N in the equation, i.e., a value that applies to the amount of
influence the previous HEQ transformation function has on the current function. The
lower the value of N the higher the influence of the current video frame whereas
the higher the value of N the more influence the previous damped transfer function has.

Clip Limit Index 0 (AGC HEQ Clip Limit High): This parameter defines the maximum number of pixels allowed
to accumulate in any given histogram bin. Any additional pixels in a given bin are clipped.
The effect of this parameter is to limit the influence of highly-populated bins on the
resulting HEQ transformation function.

Clip Limit Index 1 (AGC HEQ Clip Limit Low): This parameter defines an artificial population that is added to
every non-empty histogram bin. In other words, if the Clip Limit Low is set to L, a bin
with an actual population of X will have an effective population of L + X. Any empty bin
that is nearby a populated bin will be given an artificial population of L. The effect of
higher values is to provide a more linear transfer function; lower values provide a more
non-linear (equalized) transfer function.

Empty Counts: This parameter specifies the maximum number of pixels in a bin that will be
interpreted as an empty bin. Histogram bins with this number of pixels or less will be
processed as an empty bin.
"""
function set_high_contrast_config(device::BrickletThermalImaging, region_of_interest, dampening_factor, clip_limit, empty_counts)
    device.deviceInternal.set_high_contrast_config(region_of_interest, dampening_factor, clip_limit, empty_counts)
end

export get_high_contrast_config
"""
    $(SIGNATURES)

Returns the high contrast config as set by :func:`Set High Contrast Config`.
"""
function get_high_contrast_config(device::BrickletThermalImaging)
    return device.deviceInternal.get_high_contrast_config()
end

export set_image_transfer_config
"""
    $(SIGNATURES)

The necessary bandwidth of this Bricklet is too high to use getter/callback or
high contrast/temperature image at the same time. You have to configure the one
you want to use, the Bricklet will optimize the internal configuration accordingly.

Corresponding functions:

* Manual High Contrast Image: :func:`Get High Contrast Image`.
* Manual Temperature Image: :func:`Get Temperature Image`.
* Callback High Contrast Image: :cb:`High Contrast Image` callback.
* Callback Temperature Image: :cb:`Temperature Image` callback.
"""
function set_image_transfer_config(device::BrickletThermalImaging, config)
    device.deviceInternal.set_image_transfer_config(config)
end

export get_image_transfer_config
"""
    $(SIGNATURES)

Returns the image transfer config, as set by :func:`Set Image Transfer Config`.
"""
function get_image_transfer_config(device::BrickletThermalImaging)
    return device.deviceInternal.get_image_transfer_config()
end

export set_flux_linear_parameters
"""
    $(SIGNATURES)

Sets the flux linear parameters that can be used for radiometry calibration.

See FLIR document 102-PS245-100-01 for more details.

.. versionadded:: 2.0.5\$nbsp;(Plugin)
"""
function set_flux_linear_parameters(device::BrickletThermalImaging, scene_emissivity, temperature_background, tau_window, temperatur_window, tau_atmosphere, temperature_atmosphere, reflection_window, temperature_reflection)
    device.deviceInternal.set_flux_linear_parameters(scene_emissivity, temperature_background, tau_window, temperatur_window, tau_atmosphere, temperature_atmosphere, reflection_window, temperature_reflection)
end

export get_flux_linear_parameters
"""
    $(SIGNATURES)

Returns the flux linear parameters, as set by :func:`Set Flux Linear Parameters`.

.. versionadded:: 2.0.5\$nbsp;(Plugin)
"""
function get_flux_linear_parameters(device::BrickletThermalImaging)
    return device.deviceInternal.get_flux_linear_parameters()
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
function get_spitfp_error_count(device::BrickletThermalImaging)
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
function set_bootloader_mode(device::BrickletThermalImaging, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletThermalImaging)
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
function set_write_firmware_pointer(device::BrickletThermalImaging, pointer)
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
function write_firmware(device::BrickletThermalImaging, data)
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
function set_status_led_config(device::BrickletThermalImaging, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletThermalImaging)
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
function get_chip_temperature(device::BrickletThermalImaging)
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
function reset(device::BrickletThermalImaging)
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
function write_uid(device::BrickletThermalImaging, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletThermalImaging)
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
function get_identity(device::BrickletThermalImaging)
    return device.deviceInternal.get_identity()
end

export get_high_contrast_image
"""
Returns the current high contrast image. See `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Thermal_Imaging.html#high-contrast-image-vs-temperature-image>`__
for the difference between
High Contrast and Temperature Image. If you don't know what to use
the High Contrast Image is probably right for you.

The data is organized as a 8-bit value 80x60 pixel matrix linearized in
a one-dimensional array. The data is arranged line by line from top left to
bottom right.

Each 8-bit value represents one gray-scale image pixel that can directly be
shown to a user on a display.

Before you can use this function you have to enable it with
:func:`Set Image Transfer Config`.
"""
function get_high_contrast_image(device::BrickletThermalImaging)

    image_length = 4800

    lock(device.stream_lock) do
        ret = get_high_contrast_image_low_level(device, )

        if ret.image_chunk_offset == (1 << 16) - 1 # maximum chunk offset -> stream has no data
            image_length = 0
            image_out_of_sync = false
            image_data = ()
        else
            image_out_of_sync = ret.image_chunk_offset != 0
        end

        image_data = ret.image_chunk_data

        while !image_out_of_sync && length(image_data) < image_length
            ret = get_high_contrast_image_low_level(device, )
            image_out_of_sync = ret.image_chunk_offset != length(image_data)
            image_data += ret.image_chunk_data
        end

        if image_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.image_chunk_offset + 62 < image_length
                ret = get_high_contrast_image_low_level(device, )
            end

            throw(TinkerforgeStreamOutOfSyncError("Image stream is out-of-sync"))
        end
    end

        return image_data[:image_length]
end

export get_temperature_image
"""
Returns the current temperature image. See `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Thermal_Imaging.html#high-contrast-image-vs-temperature-image>`__
for the difference between High Contrast and Temperature Image.
If you don't know what to use the High Contrast Image is probably right for you.

The data is organized as a 16-bit value 80x60 pixel matrix linearized in
a one-dimensional array. The data is arranged line by line from top left to
bottom right.

Each 16-bit value represents one temperature measurement in either
Kelvin/10 or Kelvin/100 (depending on the resolution set with :func:`Set Resolution`).

Before you can use this function you have to enable it with
:func:`Set Image Transfer Config`.
"""
function get_temperature_image(device::BrickletThermalImaging)

    image_length = 4800

    lock(device.stream_lock) do
        ret = get_temperature_image_low_level(device, )

        if ret.image_chunk_offset == (1 << 16) - 1 # maximum chunk offset -> stream has no data
            image_length = 0
            image_out_of_sync = false
            image_data = ()
        else
            image_out_of_sync = ret.image_chunk_offset != 0
        end

        image_data = ret.image_chunk_data

        while !image_out_of_sync && length(image_data) < image_length
            ret = get_temperature_image_low_level(device, )
            image_out_of_sync = ret.image_chunk_offset != length(image_data)
            image_data += ret.image_chunk_data
        end

        if image_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.image_chunk_offset + 31 < image_length
                ret = get_temperature_image_low_level(device, )
            end

            throw(TinkerforgeStreamOutOfSyncError("Image stream is out-of-sync"))
        end
    end

        return image_data[:image_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletThermalImaging, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
