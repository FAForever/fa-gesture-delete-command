--*******************************************************************************
-- MIT License
--
-- Copyright (c) 2024 (Jip) Willem Wijnia
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--
--*******************************************************************************

do
    local baseCreateUI = CreateUI
    function CreateUI(isReplay)
        baseCreateUI(isReplay)

        -- requires assembly patches to work:
        -- - https://github.com/FAForever/FA-Binary-Patches/pull/65
        -- - https://github.com/FAForever/FA-Binary-Patches/commit/80c1e9f849ca842a53917d52cdb7cdb1dd1d056c
        if not rawget(_G, "GetHighlightCommand") then
            print("Gesture detection is disabled")
            WARN("Missing global `GetHighlightCommand` that was introduced by https://github.com/FAForever/FA-Binary-Patches/pull/65")
            return
        end

        local version = tonumber(import("/lua/version.lua").GetVersion())
        if (not version) or version <= 3813 then
            print("Gesture detection is disabled")
            WARN("Invalid game version - expects at least game version 3813 from the FAForever community.")
        end

        -- run the module
        import("/mods/fa-gesture-delete-command/src/gesture-delete-command.lua").StartGestureDetectionThread()
    end
end
