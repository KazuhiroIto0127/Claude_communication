# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a communication experiment project that uses tmux with two panes, each running Claude Code instances with different roles:
- One instance acts as an instructor/director
- The other instance acts as a worker/executor

The goal is to test collaborative AI communication patterns where one Claude Code instance gives instructions and the other carries out the work.

## Repository Structure

This is a minimal repository currently containing only documentation. The project is in Japanese and focuses on AI-to-AI communication workflows using Claude Code.

## Usage

Run the communication setup:
```bash
./setup_communication.sh
```

This creates a tmux session with two panes:
- Left pane: Instructor Claude Code (gives instructions)
- Right pane: Worker Claude Code (executes tasks)

## Files

- `setup_communication.sh` - tmux session setup script
- `instructor_prompts.md` - Guidelines for the instructor role
- `worker_prompts.md` - Guidelines for the worker role  
- `communication_protocol.md` - Communication format and workflow
- `demo_scenario.md` - Example scenarios to test the system

## Development Notes

- The repository uses Japanese for documentation and communication
- This is an experimental project exploring multi-instance Claude Code collaboration
- Follow the communication protocol for effective AI-to-AI collaboration
