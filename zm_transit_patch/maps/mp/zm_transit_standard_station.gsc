#include maps/mp/zombies/_zm_perks;
#include maps/mp/gametypes_zm/_zm_gametype;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm_race_utility;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/_utility;

precache() //checked matches cerberus output
{
	precachemodel( "zm_collision_transit_busdepot_survival" );
}

station_treasure_chest_init() //checked matches cerberus output
{
	chest1 = getstruct( "depot_chest", "script_noteworthy" );
	level.chests = [];
	level.chests[ level.chests.size ] = chest1;
	maps/mp/zombies/_zm_magicbox::treasure_chest_init( "depot_chest" );
}

main() //checked changed to match cerberus output
{
	maps/mp/gametypes_zm/_zm_gametype::setup_standard_objects( "station" );
	station_treasure_chest_init();
	level.enemy_location_override_func = ::enemy_location_override;
	collision = spawn( "script_model", ( -6896, 4744, 0 ), 1 );
	collision setmodel( "zm_collision_transit_busdepot_survival" );
	collision disconnectpaths();
	flag_wait( "initial_blackscreen_passed" );
	level thread maps/mp/zombies/_zm_perks::perk_machine_removal( "specialty_quickrevive", "p_glo_tools_chest_tall" );
	flag_set( "power_on" );
	level setclientfield( "zombie_power_on", 1 );
	zombie_doors = getentarray( "zombie_door", "targetname" );
	foreach ( door in zombie_doors )
	{
		if ( isDefined( door.script_noteworthy ) && door.script_noteworthy == "local_electric_door" )
		{
			door trigger_off();
		}
	}
}

enemy_location_override( zombie, enemy ) //checked matches cerberus output
{
	location = enemy.origin;
	if ( is_true( self.reroute ) )
	{
		if ( isDefined( self.reroute_origin ) )
		{
			location = self.reroute_origin;
		}
	}
	return location;
}


