import re

def extract_emails(text):
    email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    emails = re.findall(email_pattern, text)
    return emails

# Example usage:
text = "Email liên hệ: example@gmail.com hoặc contact@domain.com."
print(extract_emails(text))


def extract_phone_and_emails(html):
    phone_pattern = r'\b0\d{9}\b'
    email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    phones = re.findall(phone_pattern, html)
    emails = re.findall(email_pattern, html)
    return phones, emails

# Example usage:
html_code = """
<html>
<body>
<p>Liên hệ qua số điện thoại: 0825294200 hoặc email: contact@example.com.</p>
<p>Hỗ trợ: support@domain.com</p>
</body>
</html>
"""
phones, emails = extract_phone_and_emails(html_code)
print("Phone numbers:", phones)
print("Emails:", emails)