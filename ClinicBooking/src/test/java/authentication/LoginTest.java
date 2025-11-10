/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package authentication;

import org.junit.Test;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.edge.EdgeDriver;

/**
 *
 * @author Vu Minh Khang - CE191371
 */
public class LoginTest {
    @Test
    public void testLoginPage() {
        System.out.println("Bắt đầu kiểm thử!");
        System.setProperty("webdriver.edge.driver", "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe");
        WebDriver driver = new EdgeDriver();

        driver.get("http://localhost:8080/ClinicBooking/home");
        assert driver.getTitle().contains("Login");
        System.out.println("Tiêu đề trang: " + driver.getTitle());
        System.out.println("Hoàn tất kiểm thử, kết quả hợp lệ.");
        driver.quit();
    }
   
}
