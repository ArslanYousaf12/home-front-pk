
import * as functions from "firebase-functions/v1";
import * as nodemailer from "nodemailer";
import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Configure nodemailer
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "arslanshyousaf@gmail.com", // Your Gmail address
    pass: "umfd drux inlk sall", // Your app-specific password
  },
});

export const sendWelcomeEmail = functions.auth.user().onCreate(async (user: functions.auth.UserRecord) => {
  try {
    // Check if email exists
    if (!user.email) {
      console.error("No email found for user");
      return null;
    }

    const email = user.email;
    const displayName = user.displayName || "New User";

    const mailOptions = {
      from: "arslanshyousaf@gmail.com", // Your Gmail address
      to: email,
      subject: "Welcome to Our App! 🎉",
      html: `
        <div style="font-family: Arial, sans-serif; padding: 20px;">
          <h2>Welcome to Our App, ${displayName}! 🎉</h2>
          
          <p>Thank you for joining our community. We're excited to have you on board!</p>
          
          <h3>Getting Started:</h3>
          <ul>
            <li>Complete your profile</li>
            <li>Explore our features</li>
            <li>Connect with other users</li>
          </ul>
          
          <p>If you have any questions, feel free to reply to this email.</p>
          
          <div style="margin-top: 20px; padding: 20px; background-color: #f5f5f5;">
            <p style="margin: 0;">Best regards,</p>
            <p style="margin: 5px 0;">The App Team</p>
          </div>
        </div>
      `,
    };

    // Send email
    await transporter.sendMail(mailOptions);
    console.log("Welcome email sent successfully");
    return null;
  } catch (error) {
    console.error("Error sending welcome email:", error);
    return null;
  }
});
