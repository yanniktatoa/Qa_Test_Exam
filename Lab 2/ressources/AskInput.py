# AskInput.py
from tkinter import Tk, simpledialog

def ask_input(prompt):

    root = Tk()
    root.withdraw()  
    user_input = simpledialog.askstring(title="Saisie requise", prompt=prompt)
    root.destroy()
    return user_input
