from twilio.rest import Client
from dotenv import load_dotenv
import os

load_dotenv()

TWILIO_ACCOUNT_SID=os.getenv('TWILIO_ACCOUNT_SID')
TWILIO_AUTH_TOKEN=os.getenv('TWILIO_AUTH_TOKEN')    
TWILIO_PHONE_NUMBER=os.getenv('TWILIO_PHONE_NUMBER')
TARGET_PHONE_NUMBER=os.getenv('TARGET_PHONE_NUMBER')

client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

def send_alert(message_text):
    
    message = client.messages.create(
        body = message_text,
        from_ = TWILIO_PHONE_NUMBER,
        to = TARGET_PHONE_NUMBER
    )

    print(f"Alert sent: {message.sid}")