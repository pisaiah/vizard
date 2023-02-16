// i18n.v - Localization / Translations
module main

import iui as ui

// TODO: complete translations
const (
	english = Tl{}
	spanish = Tl{
		next: 'continuar'
		back: 'atrás'
	}
	french = Tl{
		next: 'continuer'
		back: 'dos'
	}
	german = Tl{
		next: 'nachste'
		back: 'zurück'
	}
	ukraine = Tl{
		next: 'продовжити'
		back: 'назад'
	}
	russian = Tl{
		next: 'slava ukraini'
		back: 'slava ukraini'
	}
	chinese = Tl{
		next: '继续'
		back: '后退'
	}
)

pub fn by_name(name string) Tl {
	val := match name {
		'english' { english }
		'spanish' { spanish }
		'french' { french }
		'german' { german }
		'ukraine' { ukraine }
		'russian' { russian }
		'chinese' { chinese }
		else { english }
	}
	return val
}

pub struct Tl {
	next string = 'Next'
	back string = 'Back'
}

fn (mut app App) create_select() &ui.Select {
	mut sel := ui.selector(app.win, 'english', ui.SelectConfig{
		items: ['english', 'spanish', 'french', 'german', 'ukraine', 'russian', 'chinese']
	})
	app.win.id_map['app'] = app
	sel.change_event_fn = my_change_event_fn
	sel.set_bounds(534, 1, 99, 24)
	return sel
}

fn my_change_event_fn(mut win ui.Window, sel ui.Select, oldval string, newval string) {
	dump(oldval)
	dump(newval)
	mut app := unsafe { &App(win.id_map['app']) }
	app.lang = by_name(newval)
	app.next_btn.text = app.lang.next
	app.back_btn.text = app.lang.back
}
