package com.sweeth_clothes_store.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    private static final String CHARACTERS = "0123456789";
    private static final int OTP_LENGTH = 6; // Updated length to 6
    private static final SecureRandom random = new SecureRandom();

    public String generateOTP() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < OTP_LENGTH; i++) { // Use OTP_LENGTH for the number of digits
            sb.append(CHARACTERS.charAt(random.nextInt(CHARACTERS.length())));
        }
        return sb.toString();
    }

    public void sendOtpEmail(String toEmail, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("thuanldps23755@fpt.edu.vn");
        message.setTo(toEmail);
        message.setSubject("Bạn OTP Mã");
        message.setText("Mã OTP là: " + otp);
        mailSender.send(message);
    }
}

