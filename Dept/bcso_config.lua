local Vehicle_Settings = {
    [1] = {
        extras = {
            ["1"] = false,
            ["2"] = false,
            ["3"] = true,
            ["4"] = true,
            ["5"] = false,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = false,
            ["12"] = true,
        },
        livery = 0,
        Items = {
            [1] = {
                name = "firstaid",
                amount = 5,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "weapon_pumpshotgun",
                amount = 1,
                info = {
                    serie = "",
                    attachments = {
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    }
                },
                type = "weapon",
                slot = 2,
            },
            [3] = {
                name = "shotgun_ammo",
                amount = 4,
                info = {},
                type = "item",
                slot = 3,
            },
            [4] = {
                name = "weapon_carbinerifle",
                amount = 1,
                info = {
                    serie = "",
                    attachments = {
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                        {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                    }
                },
                type = "weapon",
                slot = 4,
            },
            [5] = {
                name = "rifle_ammo",
                amount = 3,
                info = {},
                type = "item",
                slot = 5,
            }
        }
    },
    [2] = {
        extras = {
            ["1"] = false,
            ["2"] = false,
            ["3"] = true,
            ["4"] = true,
            ["5"] = false,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = false,
            ["12"] = true,
        },
        livery = 0,
        Items = {
            [1] = {
                name = "firstaid",
                amount = 5,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "empty_evidence_bag",
                amount = 100,
                info = {},
                type = "item",
                slot = 2,
            },
            [3] = {
                name = "weapon_carbinerifle",
                amount = 1,
                info = {
                    serie = "",
                    attachments = {
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                        {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                    }
                },
                type = "weapon",
                slot = 3,
            },
            [4] = {
                name = "rifle_ammo",
                amount = 3,
                info = {},
                type = "item",
                slot = 4,
            }
        }
    },
    [3] = {
        extras = {
            ["1"] = false,
            ["2"] = false,
            ["3"] = true,
            ["4"] = true,
            ["5"] = false,
            ["6"] = true,
            ["7"] = true,
            ["8"] = true,
            ["9"] = true,
            ["10"] = true,
            ["11"] = false,
            ["12"] = true,
        },
        livery = 0,
        Items = {
            [1] = {
                name = "firstaid",
                amount = 15,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "weapon_pumpshotgun",
                amount = 10,
                info = {
                    serie = "",
                    attachments = {
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                    }
                },
                type = "weapon",
                slot = 2,
            },
            [3] = {
                name = "shotgun_ammo",
                amount = 40,
                info = {},
                type = "item",
                slot = 3,
            },
            [4] = {
                name = "weapon_carbinerifle",
                amount = 10,
                info = {
                    serie = "",
                    attachments = {
                        {component = "COMPONENT_AT_AR_FLSH", label = "Flashlight"},
                        {component = "COMPONENT_AT_SCOPE_MEDIUM", label = "3x Scope"},
                    }
                },
                type = "weapon",
                slot = 4,
            },
            [5] = {
                name = "rifle_ammo",
                amount = 30,
                info = {},
                type = "item",
                slot = 5,
            }
        }
    }
}

local Armory_Configurations = {
    [1] = {
        [1] = {
            name = "weapon_pistol",
            price = 0,
            amount = 1,
            info = {
                serie = "",
                attachments = {
                    {component = "COMPONENT_AT_PI_FLSH", label = "Flashlight"},
                }
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
        [2] = {
            name = "weapon_stungun",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
        [3] = {
            name = "pistol_ammo",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
        [4] = {
            name = "handcuffs",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
        [5] = {
            name = "weapon_nightstick",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
        [6] = {
            name = "weapon_flashlight",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
        [7] = {
            name = "radio",
            price = 0,
            amount = 50,
            info = {},
            type = "item",
            slot = 7,
            authorizedJobGrades = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
        },
    }
}

Config.Departments.BCSO = {
    Helicopter_Model = `polmav`,

    PlainText = "BCSO",

    Stations = {
        [1] = {
            label = "Blaine County Sheriffs Office #1",
            coords = vector4(371.33, -1598.43, 36.95, 47.76),
            blipColor = 25,

            Duty = vector3(366.95, -1602.22, 29.29),
            VehicleGarage = vector4(387.84, -1636.28, 29.29, 326.56),

            Armory = {
                Coords = vector3(367.13, -1606.95, 29.29),
                Items = Armory_Configurations[1]
            },

            Evidence = {
                Coords = vector3(380.85, -1599.45, 33.36)
            }
        },
        [2] = {
            label = "Blaine County Sheriffs Office #2",
            coords = vector4(1848.33, 3689.37, 34.33, 43.27),
            blipColor = 25,

            Duty = vector3(1854.02, 3691.89, 34.33),
            VehicleGarage = vector4(1862.3, 3706.96, 33.94, 297.36),

            Armory = {
                Coords = vector3(1842.05, 3691.48, 30.66),
                Items = Armory_Configurations[1]
            },

            Evidence = {
                Coords = vector3(1849.69, 3681.24, 30.66),
            }
        },
        [3] = {
            label = "Blaine County Sheriffs Office #3",
            coords = vector4(-446.35, 6008.33, 31.72, 101.8),
            blipColor = 25,

            Duty = vector3(-449.4, 6008.33, 31.84),
            VehicleGarage = vector4(-451.42, 5998.24, 31.34, 86.33),

            Armory = {
                Coords = vector3(-430.34, 5999.08, 31.72),
                Items = Armory_Configurations[1]
            },

            Evidence = {
                Coords = vector3(-433.03, 5990.51, 31.72),
            }
        }
    },

    Subdivisions = {
        "CIU",
        "K9",
        "SWAT"
    },

    Vehicles = {
        [0] = {
            ["sop10"] = "2010 Chevy Impala",
            ["sop12"] = "2011 CVPI",
        },
        [1] = {
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop7"] = "2018 Ford Explorer",
            ["sop11"] = "2018 Ford Taurus",
        },
        [2] = {
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop7"] = "2018 Ford Explorer",
            ["sop11"] = "2018 Ford Taurus",
        },
        [3] = {
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop7"] = "2018 Ford Explorer",
            ["sop11"] = "2018 Ford Taurus",
        },
        [4] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [5] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [6] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [7] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [8] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [9] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [10] = {
            ["sop1"] = "2014 Dodge Charger",
            ["sop2"] = "2014 Chevy Tahoe",
            ["sop3"] = "2018 Dodge Charger",
            ["sop4"] = "2018 Chevy Tahoe",
            ["sop5"] = "2010 Dodge Charger",
            ["sop6"] = "2014 Ford Explorer",
            ["sop7"] = "2018 Ford Explorer",
            ["sop8"] = "2020 Dodge Durango",
            ["sop10"] = "2010 Chevy Impala",
            ["sop11"] = "2018 Ford Taurus",
            ["sop12"] = "2011 CVPI",
        },
        [11] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [12] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [13] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [14] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [15] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [16] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [17] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
        },
        [18] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos8"] = "2020 Dodge Durango",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
            ["sos13"] = "2012 Chevy Silverado",
        },
        [19] = {
            ["sos1"] = "2014 Dodge Charger",
            ["sos2"] = "2014 Chevy Tahoe",
            ["sos3"] = "2018 Dodge Charger",
            ["sos4"] = "2018 Chevy Tahoe",
            ["sos5"] = "2010 Dodge Charger",
            ["sos6"] = "2014 Ford Explorer",
            ["sos7"] = "2018 Ford Explorer",
            ["sos8"] = "2020 Dodge Durango",
            ["sos9"] = "2018 F-150",
            ["sos10"] = "2010 Chevy Impala",
            ["sos11"] = "2018 Ford Taurus",
            ["sos12"] = "2011 CVPI",
            ["sos13"] = "2012 Chevy Silverado",
        },
        ["CIU"] = {
            ["sociu1"] = "CIU - 2020 Dodge Durango",
            ["sociu2"] = "CIU - 2019 Chevy Malibu",
            ["sociu3"] = "CIU - 2022 Chevy Tahoe",
        },
        ["K9"] = {
            ["sok1"] = "K9 - 2018 Chevy Tahoe"
        },
        ["SWAT"] = {
            ["sosrt6"] = "SWAT - MRAP",
            ["sosrt5"] = "SWAT - 2018 Chevy Tahoe w/Stairs",
            ["sosrt1"] = "SWAT - 2014 Dodge Charger",
            ["sosrt2"] = "SWAT - 2018 Ford F-150",
            ["sosrt3"] = "SWAT - 2014 Chevy Tahoe",
            ["sosrt4"] = "SWAT - 2018 Ford Interceptor Sedan"
        }
    },

    VehicleSettings = {
        ["sop1"] =          {Settings = Vehicle_Settings[1], Price = 27000},
        ["sop2"]  =         {Settings = Vehicle_Settings[1], Price = 40000},
        ["sop3"]  =         {Settings = Vehicle_Settings[1], Price = 36100},
        ["sop4"]  =         {Settings = Vehicle_Settings[1], Price = 44995},
        ["sop5"]  =         {Settings = Vehicle_Settings[1], Price = 11500},
        ["sop6"]  =         {Settings = Vehicle_Settings[1], Price = 29500},
        ["sop7"]  =         {Settings = Vehicle_Settings[1], Price = 32000},
        ["sop8"]  =         {Settings = Vehicle_Settings[1], Price = 33877},
        ["sop9"]  =         {Settings = Vehicle_Settings[1], Price = 34265},
        ["sop10"]  =        {Settings = Vehicle_Settings[1], Price = 31620},
        ["sop11"]  =        {Settings = Vehicle_Settings[1], Price = 35000},
        ["sop12"]  =        {Settings = Vehicle_Settings[1], Price = 8100},
        ["sos1"]  =         {Settings = Vehicle_Settings[1], Price = 27000},
        ["sos2"]  =         {Settings = Vehicle_Settings[1], Price = 40000},
        ["sos3"]  =         {Settings = Vehicle_Settings[1], Price = 36100},
        ["sos4"]  =         {Settings = Vehicle_Settings[1], Price = 44995},
        ["sos5"]  =         {Settings = Vehicle_Settings[1], Price = 11500},
        ["sos6"]  =         {Settings = Vehicle_Settings[1], Price = 29500},
        ["sos7"]  =         {Settings = Vehicle_Settings[1], Price = 32000},
        ["sos8"]  =         {Settings = Vehicle_Settings[1], Price = 33877},
        ["sos9"]  =         {Settings = Vehicle_Settings[1], Price = 34265},
        ["sos10"]  =        {Settings = Vehicle_Settings[1], Price = 31620},
        ["sos11"]  =        {Settings = Vehicle_Settings[1], Price = 35000},
        ["sos12"]  =        {Settings = Vehicle_Settings[1], Price = 8100},
        ["sos13"]  =        {Settings = Vehicle_Settings[1], Price = 34600},
        ["sok1"]  =         {Settings = Vehicle_Settings[1], Price = 44995},
        ["sociu1"]  =       {Settings = Vehicle_Settings[2], Price = 33877},
        ["sociu2"]  =       {Settings = Vehicle_Settings[2], Price = 24700},
        ["sociu3"]  =       {Settings = Vehicle_Settings[2], Price = 52000},
        ["sosrt1"]  =       {Settings = Vehicle_Settings[3], Price = 27000},
        ["sosrt2"]  =       {Settings = Vehicle_Settings[3], Price = 34265},
        ["sosrt3"]  =       {Settings = Vehicle_Settings[3], Price = 36100},
        ["sosrt4"]  =       {Settings = Vehicle_Settings[3], Price = 35000},
        ["sosrt5"]  =       {Settings = Vehicle_Settings[3], Price = 44995},
        ["sosrt6"]  =       {Settings = Vehicle_Settings[3], Price = 500000},
    },
    VehicleHashes = {
        [`sop1`] = "sop1",
        [`sop2`] = "sop2",
        [`sop3`] = "sop3",
        [`sop4`] = "sop4",
        [`sop5`] = "sop5",
        [`sop6`] = "sop6",
        [`sop7`] = "sop7",
        [`sop8`] = "sop8",
        [`sop9`] = "sop9",
        [`sop10`] = "sop10",
        [`sop11`] = "sop11",
        [`sop12`] = "sop12",
        [`sos1`] = "sos1",
        [`sos2`] = "sos2",
        [`sos3`] = "sos3",
        [`sos4`] = "sos4",
        [`sos5`] = "sos5",
        [`sos6`] = "sos6",
        [`sos7`] = "sos7",
        [`sos8`] = "sos8",
        [`sos9`] = "sos9",
        [`sos10`] = "sos10",
        [`sos11`] = "sos11",
        [`sos12`] = "sos12",
        [`sos13`] = "sos13",
        [`sok1`] = "sok1",
        [`sociu1`] = "sociu1",
        [`sociu2`] = "sociu2",
        [`sociu3`] = "sociu3",
        [`sosrt1`] = "sosrt1",
        [`sosrt2`] = "sosrt2",
        [`sosrt3`] = "sosrt3",
        [`sosrt4`] = "sosrt4",
        [`sosrt5`] = "sosrt5",
        [`sosrt6`] = "sosrt6",
    },
    VehicleEquipmentMultiplier = 0.1, -- 10%
}