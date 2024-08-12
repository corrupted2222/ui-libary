local oldnamecall = nil
oldnamecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    if (not checkcaller()) and (getnamecallmethod() == "Kick") then
       return nil
    end
    return(oldnamecall(Self, ...))
end))
