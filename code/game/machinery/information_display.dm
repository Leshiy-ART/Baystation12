//надеюсь в скором времени переписать (Volas)
//переписываю (Leshiy)
/obj/machinery/information_display
	name = "Information display"
	icon = 'icons/obj/information_display.dmi'
	icon_state = "screen_animation"
	anchored = 1
	density = 0
	use_power = 1
	idle_power_usage = 25

	var/mode = 1//1 - on
				//2 - off
				//3 - broken
	var/icon_state_on = "screen_animation"
	var/icon_state_off = "screen_off"
	var/icon_state_break = "screen_break"

/obj/machinery/information_display/process()
	if(stat & (NOPOWER|BROKEN))
		switch_display(2)
		return

/obj/machinery/information_display/emp_act(severity)
	if(stat & (BROKEN|NOPOWER))
		return
	switch_display(3)
	..(severity)

/obj/machinery/information_display/verb/switch_verb()
	set src in oview(1)
	set name = "Switch monitor"
	set category = "Object"

	if (usr.stat != 0 || !ishuman(usr))
		return

	add_fingerprint(usr)
	switch_display()

/obj/machinery/information_display/proc/switch_display(var/new_mode = 0)
	switch(new_mode)
		if(1)//on
			if(stat & (NOPOWER|BROKEN))		return
			use_power = 1
			icon_state = icon_state_on
			mode = new_mode

		if(2)//off
			use_power = 0
			icon_state = icon_state_off
			mode = new_mode

		if(3)//broken
			use_power = 0
			icon_state = icon_state_break
			mode = new_mode
		else
			if(mode == 1)
				switch_display(2)
			else if(mode == 2)
				switch_display(1)
			else if(mode == 3)
				usr << "\blue Reload monitor..."
				sleep(15)
				usr << "\blue Done!"
				switch_display(1)

/obj/machinery/information_display/information_display90
	icon = 'icons/obj/information_display_90.dmi'
	dir = 8