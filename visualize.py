import matplotlib.pyplot as plt
import matplotlib.patches as patches

# Data values from SQL exports
N = 67
fears_data = {'Aggressive Behavior': 21, 'Inappropriate Content': 27, 'Adverse Health': 28, 'Academic Decline': 35, 'Gaming Addiction': 38}
perc_data = {'Beneficial to Kids': 26, 'Stress-Buster': 37, 'Dangerous Consequences': 45, 'Major Distraction': 58}
impact_data = {'Relationship Strain': 36, 'Arguments & Conflicts': 37, 'Family Frustration': 42}

fears = list(fears_data.keys())
fear_pcts = [round(val * 100 / N, 1) for val in fears_data.values()]

perceptions = list(perc_data.keys())
perc_pcts = [round(val * 100 / N, 1) for val in perc_data.values()]

impacts = list(impact_data.keys())
impact_pcts = [round(val * 100 / N, 1) for val in impact_data.values()]

# Setup Figure
fig = plt.figure(figsize=(10, 14), facecolor='#F8FAFC')
fig.text(0.5, 0.96, "UNPLUGGING THE FRICTION: PARENTS & ONLINE GAMING", ha='center', va='center', fontsize=18, fontweight='bold', color='#0F172A')
fig.text(0.5, 0.94, "YourDOST Digital Wellness Survey Analysis (N = 100 Parents)", ha='center', va='center', fontsize=12, color='#475569', fontstyle='italic')

# KPI Banner Axes (Metrics: 100 total, 67 active, 58 distraction, 42 frustration)
ax_kpi = fig.add_axes([0.08, 0.83, 0.84, 0.08])
ax_kpi.axis('off')

kpi_items = [
    ("100", "Total Surveyed", "#475569"),
    ("67", "Active Gamers", "#0284C7"),
    ("58", "See Distraction", "#DC2626"),
    ("42", "Report Frustration", "#7C3AED")
]

for i, (val, label, col) in enumerate(kpi_items):
    x_pos = i * 0.25
    card = patches.FancyBboxPatch((x_pos + 0.01, 0.05), 0.22, 0.9, boxstyle="round,pad=0.03", fc='white', ec='#E2E8F0', lw=1.5)
    ax_kpi.add_patch(card)
    ax_kpi.text(x_pos + 0.12, 0.62, val, ha='center', va='center', fontsize=16, fontweight='bold', color=col)
    ax_kpi.text(x_pos + 0.12, 0.25, label, ha='center', va='center', fontsize=8.5, color='#334155', weight='semibold')

# Chart 1: Top Parental Fears
ax1 = fig.add_axes([0.12, 0.57, 0.78, 0.21])
bars1 = ax1.barh(fears, fear_pcts, color=['#818CF8', '#34D399', '#60A5FA', '#FBBF24', '#F87171'], height=0.55)
ax1.set_title("1. Top Parental Fears (% High Fear | Active N=67)", fontsize=11, fontweight='bold', color='#1E293B', pad=12, loc='left')
ax1.set_xlim(0, 70)
ax1.spines['top'].set_visible(False)
ax1.spines['right'].set_visible(False)
ax1.grid(axis='x', linestyle='--', alpha=0.5, color='#94A3B8')
for bar, pct in zip(bars1, fear_pcts):
    ax1.text(bar.get_width() + 1.5, bar.get_y() + bar.get_height()/2, f"{pct}%", va='center', ha='left', fontsize=9.5, fontweight='bold', color='#1E293B')

# Chart 2: Dual Perception Paradox
ax2 = fig.add_axes([0.12, 0.32, 0.78, 0.18])
bars2 = ax2.barh(perceptions, perc_pcts, color=['#10B981', '#0EA5E9', '#F97316', '#EF4444'], height=0.52)
ax2.set_title("2. The Dual-Perception Paradox (% Agreement)", fontsize=11, fontweight='bold', color='#1E293B', pad=12, loc='left')
ax2.set_xlim(0, 100)
ax2.spines['top'].set_visible(False)
ax2.spines['right'].set_visible(False)
ax2.grid(axis='x', linestyle='--', alpha=0.5, color='#94A3B8')
for bar, pct in zip(bars2, perc_pcts):
    ax2.text(bar.get_width() + 2, bar.get_y() + bar.get_height()/2, f"{pct}%", va='center', ha='left', fontsize=9.5, fontweight='bold', color='#1E293B')

# Chart 3: Domestic Impact
ax3 = fig.add_axes([0.12, 0.11, 0.78, 0.15])
bars3 = ax3.barh(impacts, impact_pcts, color=['#C084FC', '#F472B6', '#A855F7'], height=0.5)
ax3.set_title("3. Domestic Fallout (% Medium-to-High Impact)", fontsize=11, fontweight='bold', color='#1E293B', pad=12, loc='left')
ax3.set_xlim(0, 80)
ax3.spines['top'].set_visible(False)
ax3.spines['right'].set_visible(False)
ax3.grid(axis='x', linestyle='--', alpha=0.5, color='#94A3B8')
for bar, pct in zip(bars3, impact_pcts):
    ax3.text(bar.get_width() + 1.5, bar.get_y() + bar.get_height()/2, f"{pct}%", va='center', ha='left', fontsize=9.5, fontweight='bold', color='#1E293B')

# Footer
fig.text(0.5, 0.04, "Key Recommendation: Shift from rigid unilateral bans to collaborative digital boundaries and joint rules.", ha='center', va='center', fontsize=9.5, fontweight='bold', color='#0F172A', bbox=dict(boxstyle='round,pad=0.5', facecolor='#F1F5F9', edgecolor='#CBD5E1', lw=1))
fig.text(0.5, 0.015, "YourDOST Digital Wellness Analytics | www.yourdost.com", ha='center', va='center', fontsize=8, color='#64748B')

# Save Output
plt.savefig('yourdost_infographic_kpi.png', dpi=300, bbox_inches='tight')
plt.show()