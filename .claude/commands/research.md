---
name: research
description: Research a topic via web search, synthesize into markdown, write to research/
context: fork
agent: Explore
---

Research the following topic: $ARGUMENTS

## Instructions

1. Search the web for current information on the topic
2. Fetch and read the most relevant 3-5 sources
3. Check if related files exist in the current project for context
4. Synthesize findings into a structured markdown document with:
   - Summary (2-3 sentences)
   - Key findings with source attribution
   - Relevance to the current project
   - Recommendations or action items
   - References list
5. Write the output to `research/` within the current project directory, with a descriptive filename
6. Return ONLY a brief summary (3-5 sentences) of what was found and where it was saved

## Output Format
- Filename: descriptive, snake_case, dated if time-sensitive
- Header: include date, status (RESEARCH), and topic
- Keep factual, include measurements/specs where available
