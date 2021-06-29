import sys
import subprocess

print("Running shell")

subprocess.call(["sh", "./rce.sh", "CHECKOV"])

sys.exit("DONE!")
