from tkinter import Tk, StringVar, ttk
STATES = [
    "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
    "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
    "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana",
    "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina",
    "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
    "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia",
    "Wisconsin", "Wyoming"
]

def center_window(root, width=300, height=150):
    root.update_idletasks()
    screen_width = root.winfo_screenwidth()
    screen_height = root.winfo_screenheight()
    x = (screen_width // 2) - (width // 2)
    y = (screen_height // 2) - (height // 2)
    root.geometry(f"{width}x{height}+{x}+{y}")

def ask_select(prompt, options=None):
    if options is None:
        options = STATES
    root = Tk()
    center_window(root)
    root.title("Sélection requise")
    var = StringVar(value=options[0])

    def validate():
        root.quit()

    ttk.Label(root, text=prompt).pack(padx=10, pady=10)
    combo = ttk.Combobox(root, textvariable=var, values=options, state="readonly")
    combo.pack(padx=10, pady=10)
    ttk.Button(root, text="Valider", command=validate).pack(pady=10)

    root.mainloop()
    result = var.get()
    root.destroy()
    return result