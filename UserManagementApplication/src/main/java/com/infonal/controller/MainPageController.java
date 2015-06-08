package com.infonal.controller;

import javax.servlet.http.HttpServletRequest;

import net.tanesha.recaptcha.ReCaptcha;
import net.tanesha.recaptcha.ReCaptchaResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.infonal.model.User;
import com.infonal.service.MainPageService;

//GUI management on the controller class.

@Controller
public class MainPageController {

	@Autowired
	MainPageService mainPageService;
	@Autowired
	ReCaptcha reCaptcha;

	@RequestMapping(method = RequestMethod.GET, value = "/")
	public ModelAndView getMainPage() {
		ModelAndView myModelAndView = new ModelAndView("index");
		myModelAndView.addObject("myUserList", mainPageService.getAllUsers());
		myModelAndView.addObject("userForm", new User());

		return myModelAndView;
	}

	@RequestMapping(method = RequestMethod.POST, value = "/submitedform")
	public ModelAndView getMainPageSubmitForm(@ModelAttribute User myUser,
			HttpServletRequest myrequest) {
		ModelAndView myModelAndView = new ModelAndView("index");

		myModelAndView.addObject("userForm", new User());
		String remoteAddr = myrequest.getRemoteAddr();
		String challenge = myrequest.getParameter("recaptcha_challenge_field");
		String uresponse = myrequest.getParameter("recaptcha_response_field");
		ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr,
				challenge, uresponse);

		if (reCaptchaResponse.isValid()) {
			mainPageService.insertUser(myUser);
		} else {
			myModelAndView.addObject("wrongCaptcha", "Your Capcha is WRONG!");
		}
		myModelAndView.addObject("myUserList", mainPageService.getAllUsers());
		return myModelAndView;
	}

	@RequestMapping(method = RequestMethod.POST, value = "/deleteUser")
	public @ResponseBody
	String getMainPageDeleteForm(
			@RequestParam(value = "id", required = true) String myUser) {
		System.out.println(myUser);
		mainPageService.removeUser(myUser);
		return "true";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/updateUser")
	public @ResponseBody
	String getMainPageUpdateUser(
			@RequestParam(value = "id", required = true) String myUser,
			@RequestParam(value = "editUserName", required = true) String editUserName,
			@RequestParam(value = "editUserSurName", required = true) String editUserSurName,
			@RequestParam(value = "editTel", required = true) String editTel) {

		User user = new User();
		user.setUserId(myUser);
		user.setPhoneNo(editTel);
		user.setUserName(editUserName);
		user.setUserSurname(editUserSurName);
		mainPageService.updateUser(user);
		return "true";
	}

}
