import sys
import time
import signal


def interruptHandler(signum, frame):
    print(f"[PYTHON] Handling signal {signum} ({signal.Signals(signum).name}).")
    time.sleep(1)
    sys.exit(0)


def main():
    while True:
        print(".", end="", flush=True)
        time.sleep(0.3)

    
if __name__ == "__main__":
    signal.signal(signal.SIGINT, interruptHandler)
    main()
