package com.sykj.app.model.menu;

import java.util.List;



public class ComplexButton extends MenuButton {
	private List<MenuButton> sub_button;

	public List<MenuButton> getSub_button() {
		return sub_button;
	}

	public void setSub_button(List<MenuButton> sub_button) {
		this.sub_button = sub_button;
	}

	
}
