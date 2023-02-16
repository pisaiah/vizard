module main

import iui as ui
import gx

const (
	// bg_sidebar = gx.rgb(0, 83, 150)
	bg_sidebar = gx.rgb(40, 90, 150)
	bg_bottom  = gx.rgb(220, 220, 220)
	bg_line    = gx.rgb(156, 160, 157)
)

struct App {
mut:
	win      &ui.Window
	bottom   &ui.HBox
	lang     Tl
	next_btn &ui.Button
	back_btn &ui.Button
	canc_btn &ui.Button
}

fn main() {
	// Create Window
	mut window := ui.make_window(
		title: 'My Program - InstallShield Wizard'
		width: 640
		height: 480
		theme: ui.theme_default()
		font_size: 18
	)
	// window.set_theme(ui.theme_ocean())

	side_bg := gx.rgb(0, 83, 150)

	mut sidebox := ui.hbox(window)
	sidebox.subscribe_event('draw', sidebox_draw_fn)

	mut bottom_box := ui.hbox(window)
	bottom_box.subscribe_event('draw', bottom_box_draw_fn)

	mut app := &App{
		win: window
		bottom: bottom_box
	}

	title_text := 'Preparing to Install'
	mut title := ui.label(window, title_text)
	title.set_config(32, true, true)

	// placeholder demo text
	demo_text := 'InstallShield 11 Setup is preparing the InstallShield Wizard,\nwhich will guide you though the program setup process.\nPlease Wait.'
	mut lbl := ui.label(window, demo_text)

	title.set_pos(200, 45)
	lbl.set_pos(200, 115)

	mut lb := app.create_select()
	window.add_child(lb)

	window.add_child(sidebox)
	window.add_child(bottom_box)
	window.add_child(title)
	window.add_child(lbl)

	app.create_buttons()

	// Start GG / Show Window
	window.run()
}

fn (mut app App) create_buttons() {
	mut lbl := ui.label(app.win, 'Powered by Vizard™')
	lbl.set_pos(4, 10)
	lbl.pack()

	// lbl.pack()
	lbl.set_config(12, true, false)

	mut bb := ui.button(
		text: 'Back'
		bounds: ui.Bounds{220, 0, 90, 30}
	)

	mut btn := ui.button(
		text: 'Next'
		bounds: ui.Bounds{4, 0, 90, 30}
	)

	mut cb := ui.button(
		text: 'Cancel'
		bounds: ui.Bounds{30, 0, 80, 30}
	)

	app.next_btn = btn
	app.back_btn = bb
	app.canc_btn = cb

	app.bottom.add_child(lbl)
	app.bottom.add_child(bb)
	app.bottom.add_child(btn)
	app.bottom.add_child(cb)
}

fn sidebox_draw_fn(mut e ui.DrawEvent) {
	h := 480
	e.ctx.gg.draw_rect_filled(0, 0, 180, h - 63, bg_sidebar)

	color := gx.rgba(0, 0, 0, 3)
	for i in 0 .. 8 {
		y := 200 + (i * 3)
		e.ctx.gg.draw_rect_filled(0, y, 180, h - 63 - y - 1, color)
	}
}

fn bottom_box_draw_fn(mut e ui.DrawEvent) {
	w := 640
	h := 480
	e.ctx.gg.draw_rect_filled(0, h - 60, w, 60, e.ctx.theme.dropdown_border)
	e.ctx.gg.draw_rect_filled(0, h - 62, w, 1, bg_line)

	e.target.x = 4 // 190
	e.target.y = h - 60 + 14
	e.target.width = w - 8 // 195
	e.target.height = 60
}
