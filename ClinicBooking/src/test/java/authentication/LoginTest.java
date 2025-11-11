///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package authentication;
//
//import org.junit.Test;
//import org.openqa.selenium.By;
//import org.openqa.selenium.WebDriver;
//import org.openqa.selenium.WebElement;
//import org.openqa.selenium.edge.EdgeDriver;
//import org.openqa.selenium.edge.EdgeOptions;
//
///**
// *
// * @author Vu Minh Khang - CE191371
// */
//public class LoginTest {
//
//    @Test
//    public void testLoginPage() throws InterruptedException {
//        System.out.println("Bắt đầu kiểm thử!");
//        System.setProperty("webdriver.edge.driver", "D:\\Download\\msedgedriver.exe");
//
//        // Thiết lập tùy chọn (chạy yên lặng, tránh pop-up)
//        EdgeOptions options = new EdgeOptions();
//        options.addArguments("--start-maximized");
//        WebDriver driver = new EdgeDriver(options);
//
//        // Mở trang login
//        driver.get("http://localhost:8080/ClinicBooking/patient-login");
//        Thread.sleep(2000); // đợi trang tải
//
//        // Kiểm tra tiêu đề
//        assert driver.getTitle().contains("Login");
//        System.out.println("Tiêu đề trang: " + driver.getTitle());
//
//        // --- Tự động nhập thông tin đăng nhập ---
//        WebElement usernameField = driver.findElement(By.name("patient-username"));
//        WebElement passwordField = driver.findElement(By.name("patient-password"));
//        WebElement loginButton = driver.findElement(By.xpath("//button[@type='submit' or @name='action' or contains(text(), 'Login')]"));
//
//        usernameField.sendKeys("patient01");         // nhập username mẫu
//        passwordField.sendKeys("Pass@001");    // nhập password mẫu
//
//        System.out.println("Đã nhập thông tin đăng nhập.");
//
//        // Nhấn nút đăng nhập
//        loginButton.click();
//        System.out.println("Đang thực hiện đăng nhập...");
//
//        Thread.sleep(3000); // đợi trang chuyển hướng
//
//        // Kiểm tra xem đăng nhập có thành công không
//        String currentUrl = driver.getCurrentUrl();
//        if (currentUrl.contains("home")) {
//            System.out.println("✅ Kiểm thử thành công: Đăng nhập hợp lệ.");
//        } else {
//            System.out.println("❌ Kiểm thử thất bại: Không chuyển hướng tới trang home.");
//        }
//
//        driver.quit();
//        System.out.println("Hoàn tất kiểm thử!");
//    }
//
//}
