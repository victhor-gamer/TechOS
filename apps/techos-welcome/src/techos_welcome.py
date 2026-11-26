#!/usr/bin/env python3
"""First minimal TechOS Welcome application."""

import platform
import tkinter as tk
from tkinter import ttk
import webbrowser

PROJECT_URL = "https://github.com/victhor-gamer/TechOS"


def system_summary():
    return (
        f"Architecture: {platform.machine()}\n"
        f"Python: {platform.python_version()}\n"
        f"System: {platform.system()} {platform.release()}"
    )


def main():
    root = tk.Tk()
    root.title("Welcome to TechOS")
    root.geometry("680x460")
    root.minsize(560, 400)
    root.configure(bg="#eaf7ff")

    style = ttk.Style()
    style.theme_use("clam")
    style.configure("TButton", font=("Sans", 10), padding=(14, 8))
    style.configure("Title.TLabel", background="#eaf7ff", foreground="#075985",
                    font=("Sans", 25, "bold"))
    style.configure("Body.TLabel", background="#eaf7ff", foreground="#164e63",
                    font=("Sans", 11))
    style.configure("Card.TFrame", background="#ffffff")

    outer = ttk.Frame(root, padding=28)
    outer.configure(style="Card.TFrame")
    outer.pack(fill="both", expand=True, padx=22, pady=22)

    ttk.Label(outer, text="Welcome to TechOS", style="Title.TLabel").pack(anchor="w", pady=(8, 4))
    ttk.Label(
        outer,
        text="O futuro que o passado imaginou, continua.",
        style="Body.TLabel",
    ).pack(anchor="w", pady=(0, 22))

    ttk.Label(
        outer,
        text="TechOS is a Debian-based Linux distribution in early development. "
             "This is the first experimental welcome-screen prototype.",
        style="Body.TLabel",
        wraplength=560,
    ).pack(anchor="w", pady=(0, 20))

    ttk.Label(outer, text="System information", style="Body.TLabel").pack(anchor="w")
    info = tk.Label(
        outer,
        text=system_summary(),
        justify="left",
        anchor="w",
        bg="#f0f9ff",
        fg="#164e63",
        font=("Monospace", 10),
        padx=14,
        pady=12,
    )
    info.pack(fill="x", pady=(8, 22))

    buttons = ttk.Frame(outer)
    buttons.pack(anchor="w")
    ttk.Button(
        buttons,
        text="TechOS on GitHub",
        command=lambda: webbrowser.open(PROJECT_URL),
    ).pack(side="left", padx=(0, 10))
    ttk.Button(buttons, text="Close", command=root.destroy).pack(side="left")

    ttk.Label(
        outer,
        text="TechOS 1.0 Unstable • Experimental software",
        style="Body.TLabel",
    ).pack(anchor="w", side="bottom", pady=(24, 0))

    root.mainloop()


if __name__ == "__main__":
    main()
