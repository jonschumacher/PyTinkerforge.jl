


export BrickletNFCRFIDTagID
struct BrickletNFCRFIDTagID
    tag_type::Integer
    tid_length::Integer
    tid::Vector{Integer}
end

export BrickletNFCRFIDState
struct BrickletNFCRFIDState
    state::Integer
    idle::Bool
end

export BrickletNFCRFIDIdentity
struct BrickletNFCRFIDIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletNFCRFID
"""
Reads and writes NFC and RFID tags
"""
mutable struct BrickletNFCRFID <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletNFCRFID(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_nfc_rfid")
        deviceInternal = package.BrickletNFCRFID(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export request_tag_id
"""
    $(SIGNATURES)

To read or write a tag that is in proximity of the NFC/RFID Bricklet you
first have to call this function with the expected tag type as parameter.
It is no problem if you don't know the tag type. You can cycle through
the available tag types until the tag gives an answer to the request.

Currently the following tag types are supported:

* Mifare Classic
* NFC Forum Type 1
* NFC Forum Type 2

After you call :func:`Request Tag ID` the NFC/RFID Bricklet will try to read
the tag ID from the tag. After this process is done the state will change.
You can either register the :cb:`State Changed` callback or you can poll
:func:`Get State` to find out about the state change.

If the state changes to *RequestTagIDError* it means that either there was
no tag present or that the tag is of an incompatible type. If the state
changes to *RequestTagIDReady* it means that a compatible tag was found
and that the tag ID could be read out. You can now get the tag ID by
calling :func:`Get Tag ID`.

If two tags are in the proximity of the NFC/RFID Bricklet, this
function will cycle through the tags. To select a specific tag you have
to call :func:`Request Tag ID` until the correct tag id is found.

In case of any *Error* state the selection is lost and you have to
start again by calling :func:`Request Tag ID`.
"""
function request_tag_id(device::BrickletNFCRFID, tag_type)
    device.deviceInternal.request_tag_id(tag_type)
end

export get_tag_id
"""
    $(SIGNATURES)

Returns the tag type, tag ID and the length of the tag ID
(4 or 7 bytes are possible length). This function can only be called if the
NFC/RFID is currently in one of the *Ready* states. The returned ID
is the ID that was saved through the last call of :func:`Request Tag ID`.

To get the tag ID of a tag the approach is as follows:

1. Call :func:`Request Tag ID`
2. Wait for state to change to *RequestTagIDReady* (see :func:`Get State` or
   :cb:`State Changed` callback)
3. Call :func:`Get Tag ID`
"""
function get_tag_id(device::BrickletNFCRFID)
    return device.deviceInternal.get_tag_id()
end

export get_state
"""
    $(SIGNATURES)

Returns the current state of the NFC/RFID Bricklet.

On startup the Bricklet will be in the *Initialization* state. The
initialization will only take about 20ms. After that it changes to *Idle*.

The functions of this Bricklet can be called in the *Idle* state and all of
the *Ready* and *Error* states.

Example: If you call :func:`Request Page`, the state will change to
*RequestPage* until the reading of the page is finished. Then it will change
to either *RequestPageReady* if it worked or to *RequestPageError* if it
didn't. If the request worked you can get the page by calling :func:`Get Page`.

The same approach is used analogously for the other API functions.
"""
function get_state(device::BrickletNFCRFID)
    return device.deviceInternal.get_state()
end

export authenticate_mifare_classic_page
"""
    $(SIGNATURES)

Mifare Classic tags use authentication. If you want to read from or write to
a Mifare Classic page you have to authenticate it beforehand.
Each page can be authenticated with two keys: A (``key_number`` = 0) and B
(``key_number`` = 1). A new Mifare Classic
tag that has not yet been written to can be accessed with key A
and the default key ``[0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]``.

The approach to read or write a Mifare Classic page is as follows:

1. Call :func:`Request Tag ID`
2. Wait for state to change to *RequestTagIDReady* (see :func:`Get State`
   or :cb:`State Changed` callback)
3. If looking for a specific tag then call :func:`Get Tag ID` and check if the
   expected tag was found, if it was not found go back to step 1
4. Call :func:`Authenticate Mifare Classic Page` with page and key for the page
5. Wait for state to change to *AuthenticatingMifareClassicPageReady* (see
   :func:`Get State` or :cb:`State Changed` callback)
6. Call :func:`Request Page` or :func:`Write Page` to read/write page
"""
function authenticate_mifare_classic_page(device::BrickletNFCRFID, page, key_number, key)
    device.deviceInternal.authenticate_mifare_classic_page(page, key_number, key)
end

export write_page
"""
    $(SIGNATURES)

Writes 16 bytes starting from the given page. How many pages are written
depends on the tag type. The page sizes are as follows:

* Mifare Classic page size: 16 byte (one page is written)
* NFC Forum Type 1 page size: 8 byte (two pages are written)
* NFC Forum Type 2 page size: 4 byte (four pages are written)

The general approach for writing to a tag is as follows:

1. Call :func:`Request Tag ID`
2. Wait for state to change to *RequestTagIDReady* (see :func:`Get State` or
   :cb:`State Changed` callback)
3. If looking for a specific tag then call :func:`Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Write Page` with page number and data
5. Wait for state to change to *WritePageReady* (see :func:`Get State` or
   :cb:`State Changed` callback)

If you use a Mifare Classic tag you have to authenticate a page before you
can write to it. See :func:`Authenticate Mifare Classic Page`.
"""
function write_page(device::BrickletNFCRFID, page, data)
    device.deviceInternal.write_page(page, data)
end

export request_page
"""
    $(SIGNATURES)

Reads 16 bytes starting from the given page and stores them into a buffer.
The buffer can then be read out with :func:`Get Page`.
How many pages are read depends on the tag type. The page sizes are
as follows:

* Mifare Classic page size: 16 byte (one page is read)
* NFC Forum Type 1 page size: 8 byte (two pages are read)
* NFC Forum Type 2 page size: 4 byte (four pages are read)

The general approach for reading a tag is as follows:

1. Call :func:`Request Tag ID`
2. Wait for state to change to *RequestTagIDReady* (see :func:`Get State`
   or :cb:`State Changed` callback)
3. If looking for a specific tag then call :func:`Get Tag ID` and check if the
   expected tag was found, if it was not found got back to step 1
4. Call :func:`Request Page` with page number
5. Wait for state to change to *RequestPageReady* (see :func:`Get State`
   or :cb:`State Changed` callback)
6. Call :func:`Get Page` to retrieve the page from the buffer

If you use a Mifare Classic tag you have to authenticate a page before you
can read it. See :func:`Authenticate Mifare Classic Page`.
"""
function request_page(device::BrickletNFCRFID, page)
    device.deviceInternal.request_page(page)
end

export get_page
"""
    $(SIGNATURES)

Returns 16 bytes of data from an internal buffer. To fill the buffer
with specific pages you have to call :func:`Request Page` beforehand.
"""
function get_page(device::BrickletNFCRFID)
    return device.deviceInternal.get_page()
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
function get_identity(device::BrickletNFCRFID)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletNFCRFID, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
