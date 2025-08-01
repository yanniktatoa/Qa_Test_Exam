from tkinter import Tk, StringVar, ttk, Radiobutton

GENRES = ["Male", "Female"]

def center_window(root, width=300, height=150):
    root.update_idletasks()
    screen_width = root.winfo_screenwidth()
    screen_height = root.winfo_screenheight()
    x = (screen_width // 2) - (width // 2)
    y = (screen_height // 2) - (height // 2)
    root.geometry(f"{width}x{height}+{x}+{y}")

def ask_radio(prompt, options=None):
    if options is None:
        options = GENRES
    root = Tk()
    center_window(root)
    root.title("Sélection requise")
    var = StringVar(value=options[0])

    def validate():
        root.quit()

    ttk.Label(root, text=prompt).pack(padx=10, pady=10)
    for opt in options:
        Radiobutton(root, text=opt, variable=var, value=opt).pack(anchor="w", padx=20)
    ttk.Button(root, text="Valider", command=validate).pack(pady=10)

    root.mainloop()
    result = var.get()
    root.destroy()
    return result